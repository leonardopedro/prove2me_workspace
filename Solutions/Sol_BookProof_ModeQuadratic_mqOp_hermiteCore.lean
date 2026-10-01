-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.mqOp_hermiteCore
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
import Theorems.Thm_BookProof_ModeQuadratic_mqQuadPoly_hermiteMv
import Theorems.Thm_BookProof_ModeQuadratic_ascend2_Lp
import Theorems.Thm_BookProof_ModeQuadratic_descend2_Lp
import Theorems.Thm_BookProof_HermiteProductBasis_pgMap_apply
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreOp_coe
open BookProof.ModeQuadratic




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 1600000 in
-- the core coercions make the elaboration of this transport expensive
theorem solution (p q s b b' : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    mqOp p q s b b' (hermiteCore a)
      = ((mqSymbol p q a : ℝ) : ℂ) • hermiteMvLp a
        + (∑ i, ((mqAmp p q s i * ((rc2 a i : ℝ) : ℂ))
                    • hermiteMvLp (a + Finsupp.single i 2)
                + ((starRingEnd ℂ) (mqAmp p q s i) * ((lc2 a i : ℝ) : ℂ))
                    • hermiteMvLp (a - Finsupp.single i 2)))
        + ∑ i, ((foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ))
                  • hermiteMvLp (a + Finsupp.single i 1)
                + ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ))
                  • hermiteMvLp (a - Finsupp.single i 1)) := by

  have hcoe : (mqOp p q s b b' (hermiteCore a) : L2d d)
      = ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgMap (mqPoly p q s b b' (hermiteMv a)) := by
    have h := coreOp_coe (mqPoly p q s b b') (((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • hermiteMv a)
    rw [← HermiteProductBasis.pgMap_apply, map_smul (mqPoly p q s b b'),
      map_smul (pgMap (d := d))] at h
    exact h
  rw [hcoe, mqPoly, LinearMap.add_apply, mqQuadPoly_hermiteMv, map_add, map_add, map_sum,
    smul_add, smul_add, Finset.smul_sum]
  congr 1
  · congr 1
    · rw [map_smul, smul_comm, HermiteProductBasis.pgMap_apply, pgLp_hermiteMv_eq, smul_smul,
        smul_smul, mul_assoc, inv_mul_cancel₀ (hermiteMvNorm_ne_zero a), mul_one]
    · refine Finset.sum_congr rfl fun i _ => ?_
      rw [map_add, smul_add, map_smul, map_smul]
      congr 1
      · rw [smul_comm, HermiteProductBasis.pgMap_apply, ascend2_Lp, smul_smul]
      · rw [HermiteProductBasis.pgMap_apply]
        exact descend2_Lp i a ((starRingEnd ℂ) (mqAmp p q s i))
  · have hfo : ((foOp b b' (hermiteCore a) : L2d d))
        = ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgMap (foPoly b b' (hermiteMv a)) := by
      have h := coreOp_coe (foPoly b b') (((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • hermiteMv a)
      rw [← HermiteProductBasis.pgMap_apply, map_smul (foPoly b b'),
        map_smul (pgMap (d := d))] at h
      exact h
    rw [← hfo, foOp_hermiteCore]
