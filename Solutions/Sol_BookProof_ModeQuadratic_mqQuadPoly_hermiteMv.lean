-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.mqQuadPoly_hermiteMv
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
import Theorems.Thm_BookProof_ModeQuadratic_momsq_hermiteMv
import Theorems.Thm_BookProof_ModeQuadratic_xsq_hermiteMv
import Theorems.Thm_BookProof_ModeQuadratic_weylxp_hermiteMv
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
theorem solution (p q s : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    mqQuadPoly p q s (hermiteMv a)
      = ((mqSymbol p q a : ℝ) : ℂ) • hermiteMv a
        + ∑ i, (mqAmp p q s i • hermiteMv (a + Finsupp.single i 2)
              + ((starRingEnd ℂ) (mqAmp p q s i) * (a i : ℂ) * (((a i - 1 : ℕ) : ℂ)))
                  • hermiteMv (a - Finsupp.single i 2)) := by

  have hterm : ∀ i : Fin d,
      (((p i : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (momPoly i) (momPoly i)
        + ((q i : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (mulXPoly i)
        + ((s i : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (momPoly i))
          (hermiteMv a)
      = (((( q i + p i / 4) * (2 * (a i : ℝ) + 1) : ℝ)) : ℂ) • hermiteMv a
        + (mqAmp p q s i • hermiteMv (a + Finsupp.single i 2)
            + ((starRingEnd ℂ) (mqAmp p q s i) * (a i : ℂ) * (((a i - 1 : ℕ) : ℂ)))
                • hermiteMv (a - Finsupp.single i 2)) := by
    intro i
    simp only [LinearMap.add_apply, LinearMap.smul_apply]
    rw [momsq_hermiteMv, xsq_hermiteMv, weylxp_hermiteMv, mqAmp]
    simp only [map_add, map_mul, Complex.conj_ofReal, Complex.conj_I]
    push_cast
    module
  rw [mqQuadPoly, LinearMap.sum_apply]
  rw [Finset.sum_congr rfl (fun i _ => hterm i), Finset.sum_add_distrib]
  congr 1
  rw [mqSymbol, ← Finset.sum_smul]
  push_cast
  ring_nf
