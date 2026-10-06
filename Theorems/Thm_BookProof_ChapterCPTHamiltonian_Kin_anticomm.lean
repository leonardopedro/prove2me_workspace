-- Generated from ChapterCPTHamiltonian.lean — theorem BookProof.ChapterCPTHamiltonian.Kin_anticomm
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
open BookProof.ChapterCPTHamiltonian


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterCPTHamiltonian.Kin_anticomm (i j : Fin 3) (h : i ≠ j) :
    Kin i * Kin j + Kin j * Kin i = 0 := by sorry
