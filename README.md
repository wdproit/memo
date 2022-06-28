# memo

## `shuf`

```
# shuf -i 1-9
3
9
5
6
1
8
4
2
7
```

```
# shuf -i 1-9 -n 1
5
```

```
# [[ $(shuf -i 1-1 -n 1) == 1 ]] && echo "sorteggiato"
sorteggiato
```

promemoria veloce per parametro intervallo, come risultato di percentuale per sorteggio
| parametro "i" | frazione equivalente | percentuale equivalente (in caso di pipe al comando successivo) |
|---------------|----------------------|-----------------------------------------------------------------|
| 1-1           | 1/1                  | 100%                                                            |
| 1-2           | 1/2                  | 50%                                                             |
| 1-3           | 1/3                  | 33% (circa)                                                     |
| 1-4           | 1/4                  | 25%                                                             |
| 1-5           | 1/5                  | 20%                                                             |

## altro