-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.fqOp_hermiteCore
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Theorems.Thm_BookProof_FullQuadratic_fqQuadPoly_hermiteMv
import Theorems.Thm_BookProof_FullQuadratic_ascendP_Lp
import Theorems.Thm_BookProof_FullQuadratic_exchange_Lp
import Theorems.Thm_BookProof_FullQuadratic_descendP_Lp
open BookProof.FullQuadratic

















open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.CarlemanSimplex
open BookProof.ModeQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 1600000 in
-- the core coercions make the elaboration of this transport expensive
theorem solution (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    fqOp P Q S b b' (hermiteCore a)
      = ((fqSymbol P Q : ℝ) : ℂ) • hermiteMvLp a
        + (∑ i, ∑ j, ((fqAmp P Q S i j * ((rcp a i j : ℝ) : ℂ))
                    • hermiteMvLp (a + pvec i j)
                + ((starRingEnd ℂ) (fqAmp P Q S i j) * ((lcp a i j : ℝ) : ℂ))
                    • hermiteMvLp (a - pvec i j)
                + (fqExch P Q S i j * ((rcm a i j : ℝ) : ℂ))
                    • hermiteMvLp (shiftm a i j)))
        + ∑ i, ((foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ))
                  • hermiteMvLp (a + Finsupp.single i 1)
                + ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ))
                  • hermiteMvLp (a - Finsupp.single i 1)) := by

  have hcoe : (fqOp P Q S b b' (hermiteCore a) : L2d d)
      = ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgMap (fqPoly P Q S b b' (hermiteMv a)) := by
    have h := coreOp_coe (fqPoly P Q S b b') (((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • hermiteMv a)
    rw [← HermiteProductBasis.pgMap_apply, map_smul (fqPoly P Q S b b'),
      map_smul (pgMap (d := d))] at h
    exact h
  rw [hcoe, fqPoly, LinearMap.add_apply, fqQuadPoly_hermiteMv, map_add, map_add, map_sum,
    smul_add, smul_add, Finset.smul_sum]
  congr 1
  · congr 1
    · rw [map_smul, smul_comm, HermiteProductBasis.pgMap_apply, pgLp_hermiteMv_eq, smul_smul,
        smul_smul, mul_assoc, inv_mul_cancel₀ (hermiteMvNorm_ne_zero a), mul_one]
    · refine Finset.sum_congr rfl fun i _ => ?_
      rw [map_sum, Finset.smul_sum]
      refine Finset.sum_congr rfl fun j _ => ?_
      rw [map_add, map_add, smul_add, smul_add, map_smul, map_smul, map_smul]
      congr 1
      · congr 1
        · rw [smul_comm, HermiteProductBasis.pgMap_apply, ascendP_Lp, smul_smul]
        · rw [HermiteProductBasis.pgMap_apply]
          exact descendP_Lp i j a ((starRingEnd ℂ) (fqAmp P Q S i j))
      · rw [HermiteProductBasis.pgMap_apply]
        exact exchange_Lp i j a (fqExch P Q S i j)
  · have hfo : ((foOp b b' (hermiteCore a) : L2d d))
        = ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgMap (foPoly b b' (hermiteMv a)) := by
      have h := coreOp_coe (foPoly b b') (((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • hermiteMv a)
      rw [← HermiteProductBasis.pgMap_apply, map_smul (foPoly b b'),
        map_smul (pgMap (d := d))] at h
      exact h
    rw [← hfo, foOp_hermiteCore]
