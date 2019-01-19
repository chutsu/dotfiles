- Find difference between git branches
- Update old_branch against target_branch
- Remove git submodule
- Pull latests submodules
- Reset git branch
- Fix commit message
- Undo last commit
- How to supress 'modified content'/dirty submodule entries?
- Remove local branches no longer on remote
- Fix commit in wrong branch
- Push to both github and bitbucket


## Find difference between git branches

    git diff --name-status master..branchName


## Update old_branch against target_branch

    git checkout <old_branch>
    git rebase <target-branch>


## Remove git submodule

    git submodule deinit <submodule>
    git rm --cached <submodule>
    git rm <submodule>


## Pull latests submodules

    git submodule foreach git pull


## Reset git branch

    git reset --hard HEAD  # note: this will destroy all un-commited files


## Fix commit message

    git commit --ammend
    git commit --ammend  -m "New commit Message"

If you've already pushed your commit up to your remote branch, then you'll need
to force push the commit with

    git push <remote> <branch> -f
    git push <remote> <branch> --force

**Warning**: force-pushing will overwrite the remote branch with the state of
your local one. If there are commits on the remote branch that you don't have
in your local branch, you will lose those commits.


## Undo last commit

    git commit  ..                  # what you want to undo
    git reset --soft HEAD~`         # done to correct commit
    << edit files as necessary >>   # correct working tree files
    git add ...                     # stage changes for commit
    git commit -c ORIG_HEAD         # commit changes, resuing old commit
                                    # message


Undoing a commit is a little scary if you don't know how it works. But it's
actually amazingly easy if you do understand.

Say you have this, where C is your HEAD and (F) is the state of your files.

    (F)
    A-B-C
        ^
    master

You want to nuke commit C and never see it again. You do this:

    git reset --hard HEAD~1

The result is:

    (F)
    A-B
    ^
    master

Now B is the HEAD. Because you used --hard, your files are reset to their state
at commit B.

Ah, but suppose commit C wasn't a disaster, but just a bit off. You want to
undo the commit but keep your changes for a bit of editing before you do a
better commit. Starting again from here, with C as your HEAD:

    (F)
    A-B-C
        ^
    master

You can do this, leaving off the --hard:

    git reset HEAD~1

In this case the result is:

    (F)
    A-B-C
    ^
    master

In both cases, HEAD is just a pointer to the latest commit. When you do a git
reset HEAD~1, you tell Git to move the HEAD pointer back one commit. But
(unless you use --hard) you leave your files as they were. So now git status
shows the changes you had checked into C. You haven't lost a thing!

For the lightest touch, you can even undo your commit but leave your files and
your index:

    git reset --soft HEAD~1

This not only leaves your files alone, it even leaves your index alone. When
you do git status, you'll see that the same files are in the index as before.
In fact, right after this command, you could do git commit and you'd be redoing
the same commit you just had.

One more thing: Suppose you destroy a commit as in the first example, but then
discover you needed it after all? Tough luck, right?

Nope, there's still a way to get it back. Type git reflog and you'll see a list
of (partial) commit shas that you've moved around in. Find the commit you
destroyed, and do this:

    git checkout -b someNewBranchName shaYouDestroyed

You've now resurrected that commit. Commits don't actually get destroyed in Git
for some 90 days, so you can usually go back and rescue one you didn't mean to
get rid of.


## How to supress 'modified content'/dirty submodule entries?

Add `ignore = dirty` line to the git module in `.gitmodules` file:

    [submodule "bundle/fugitive"]
      path = bundle/fugitive
      url = git://github.com/tpope/vim-fugitive.git
      ignore = dirty


## Remove local branches no longer on remote

    git remote prune origin



## Fix commit in wrong branch

If you haven't yet pushed your changes, you can also do a soft reset:

```
git reset --soft HEAD^
```

This will revert the commit, but put the committed changes back into your
index. Assuming the branches are relatively up-to-date with regard to each
other, git will let you do a checkout into the other branch, whereupon you can
simply commit:

```
git checkout branch
git commit
```

The disadvantage is that you need to re-enter your commit message.


## Push to both github and bitbucket

Often times you have a project you host on both github and bitbucket. With git
you can easily push your repo to both remote hosts.

First setup the remotes:

```
git remote add github git@github.com:<username>/<repo>.git
git remote add bitbucket git@bitbucket.org:<username>/<repo>.git
```

With the above git remote targets setup, you can explicitly push to both github
and bitbucket individually. To push to **both** remotes at the same time with
a single command, an alias can be created for that purpose:

```
git config alias.pushall '!git push bitbucket master && git push github master'
git pushall
```


## Ignore changes in git submodules

Once you added a submodule there will be a file named .gitmodules in the root
of your repository. Just the line `ignore = dirty` in the submodule section in
the `.gitmodules` file:

```
[submodule "bundle/fugitive"]
    path = bundle/fugitive
    url = git://github.com/tpope/vim-fugitive.git
    ignore = dirty
```
