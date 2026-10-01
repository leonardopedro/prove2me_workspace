-- Generated from ChapterNavierStokesFockSpace.lean — solution of BookProof.NavierStokesFlow.FockOfFock.lpDiag_basis
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_lpBasis_coe
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock





open FullEsa

set_option maxHeartbeats 1000000 in
theorem solution [DecidableEq ι] (c : ι → ℝ) (i : ι) :
    lpDiag c (lpBasis i) = ((c i : ℝ) : ℂ) • lpBasis i := by

  ext j
  by_cases h : j = i
  · subst h
    simp only [lpDiag_coe, lpBasis_coe, Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply,
      if_pos, smul_eq_mul, mul_one]
  · simp only [lpDiag_coe, lpBasis_coe, h, Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply,
      smul_eq_mul]
    simp
