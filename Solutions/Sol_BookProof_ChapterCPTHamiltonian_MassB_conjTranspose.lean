-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.MassB_conjTranspose
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_MassBZ_transpose
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_castMat_conjTranspose
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_MassB_eq_cast
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : (MassB)ᴴ = -MassB := by

  rw [MassB_eq_cast, castMat_conjTranspose, MassBZ_transpose, map_neg]
