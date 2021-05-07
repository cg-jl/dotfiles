# dotfiles

Ah, home. Sweet home. And I'm not talking about your roof, but more specifically `$HOME`. This place is the one of the most disorganised places on a dev's
computer, only `/usr/lib` and `/usr/bin` cause more havoc. But it is indeed the most beloved one. Finally, I came across a tutorial which told me how to 
set it up and not be a pain to update it. I ran this:


```sh
git --bare ~/.cfg # ~/.cfg is the directory containing the git repo, don't f with it!
```

then added this line to my fish config:

```sh
alias git-dots="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
```

and **resourced the config**

finally, told git not to annoy me with thousands of untracked

```sh
git-dots config --local status.showUntrackedFiles no
```

This is my specialization of the [atlassian tutorial](https://www.atlassian.com/git/tutorials/dotfiles). 



