-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.ghostCAR_creF_annF
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_car_annF_creF_self
import Theorems.Thm_BookProof_FermionFock_car_creF_creF
import Theorems.Thm_BookProof_FermionFock_car_annF_annF
import Theorems.Thm_BookProof_FermionFock_car_annF_creF_of_ne
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

variable {ι : Type*} [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    BookProof.BRSTNilpotent.GhostCAR (ghostChi n) (ghostBeta n) where
  chichi a b := by

    refine LinearMap.ext fun u => ?_
    simpa [ghostChi, Module.End.mul_apply] using car_creF_creF a.val b.val u
  betabeta a b := by
    refine LinearMap.ext fun u => ?_
    simpa [ghostBeta, Module.End.mul_apply] using car_annF_annF a.val b.val u
  betachi a b := by
    refine LinearMap.ext fun u => ?_
    rcases eq_or_ne a b with rfl | hab
    · simpa [ghostChi, ghostBeta, Module.End.mul_apply] using car_annF_creF_self a.val u
    · have hval : a.val ≠ b.val := fun h => hab (Fin.ext h)
      simpa [ghostChi, ghostBeta, Module.End.mul_apply, hab] using
        car_annF_creF_of_ne hval u
