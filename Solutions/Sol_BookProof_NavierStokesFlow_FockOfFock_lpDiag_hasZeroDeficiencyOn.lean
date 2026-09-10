-- Generated from ChapterNavierStokesFockSpace.lean — solution of BookProof.NavierStokesFlow.FockOfFock.lpDiag_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_lpBasis_total
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_lpDiag_basis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock









open FullEsa



variable {ι : Type*}














variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (c : ι → ℝ) :
    HasZeroDeficiencyOn (lpFiniteModes ι) (lpDiag c) := by

  classical
  exact hasZeroDeficiencyOn_of_total_eigenvectors _ _ lpBasis c (lpDiag_basis c) lpBasis_total
