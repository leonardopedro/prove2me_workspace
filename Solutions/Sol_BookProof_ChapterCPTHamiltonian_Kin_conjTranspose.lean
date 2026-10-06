-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.Kin_conjTranspose
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_KinZ_transpose
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_castMat_conjTranspose
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_Kin_eq_cast
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) : (Kin j)ᴴ = Kin j := by

  rw [Kin_eq_cast, castMat_conjTranspose, KinZ_transpose]
