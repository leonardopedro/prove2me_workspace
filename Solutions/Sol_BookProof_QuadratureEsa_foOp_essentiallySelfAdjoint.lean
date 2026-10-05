-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.foOp_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Theorems.Thm_BookProof_QuadratureEsa_foOp_pos_essentiallySelfAdjoint
import Theorems.Thm_BookProof_QuadratureEsa_linearMap_ext_of_span
import Theorems.Thm_BookProof_QuadratureEsa_hermiteCore_eq
import Theorems.Thm_BookProof_QuadratureEsa_norm_foPhase
import Theorems.Thm_BookProof_QuadratureEsa_phaseU_foOp_hermiteCore
import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvLp_mem_core
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_essentiallySelfAdjointOn_of_intertwine
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (foOp b b') := by

  refine BookProof.NavierStokesFlow.SignFlip.essentiallySelfAdjointOn_of_intertwine
    (phaseU (foPhase b b') (norm_foPhase b b')) (foOp (foMod b b') 0) (foOp b b')
    (phaseU_mem_core _ _) ?_ (foOp_pos_essentiallySelfAdjoint (foMod b b'))
  have hEq :
      ((phaseU (foPhase b b') (norm_foPhase b b')).toLinearEquiv.toLinearMap
          ∘ₗ foOp (foMod b b') 0)
        = (foOp b b' ∘ₗ phaseCore (foPhase b b') (norm_foPhase b b')) := by
    refine linearMap_ext_of_span (hermiteMvLp (d := d)) span_hermiteMvLp hermiteMvLp_mem_core
      _ _ fun a => ?_
    rw [LinearMap.comp_apply, LinearMap.comp_apply, hermiteCore_eq]
    exact phaseU_foOp_hermiteCore b b' a
  intro v
  exact congrArg (fun F : polyGaussCore (d := d) →ₗ[ℂ] L2d d => F v) hEq
