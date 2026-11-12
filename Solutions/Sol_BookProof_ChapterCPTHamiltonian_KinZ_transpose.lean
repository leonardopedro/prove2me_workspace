-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.KinZ_transpose
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3
open scoped Matrix

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) : (KinZ j)ᵀ = KinZ j := by
 revert j; decide
