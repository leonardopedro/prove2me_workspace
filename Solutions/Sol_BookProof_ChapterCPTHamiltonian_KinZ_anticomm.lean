-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.KinZ_anticomm
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) (h : i ≠ j) :
    KinZ i * KinZ j + KinZ j * KinZ i = 0 := by
 revert i j; decide
