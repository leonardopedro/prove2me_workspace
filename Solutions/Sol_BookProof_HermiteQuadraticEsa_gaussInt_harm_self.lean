-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.gaussInt_harm_self
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_HermiteQuadraticEsa_gaussInt_self
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterFiniteSectionSingleTime
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterBandEnclosure
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterFarisLavine
open BookProof.HermiteQuadraticEsa















open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : MvPolynomial (Fin d) ℂ) :
    gaussInt (cpoly q * (harmPoly * q))
      = (((∑ k : Fin d, ‖pgLp (X k * q)‖ ^ 2) / 4 : ℝ) : ℂ) := by

  have hsum : cpoly q * (harmPoly * q)
      = ∑ k : Fin d, (1 / 4 : ℂ) • (cpoly (X k * q) * (X k * q)) := by
    unfold harmPoly
    rw [Finset.sum_mul, Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [cpoly_mul, cpoly_X, smul_eq_C_mul]
    ring
  have hterm : ∀ k : Fin d, gaussInt ((1 / 4 : ℂ) • (cpoly (X k * q) * (X k * q)))
      = ((‖pgLp (X k * q)‖ ^ 2 / 4 : ℝ) : ℂ) := by
    intro k
    rw [gaussInt_smul, gaussInt_self]
    push_cast
    ring
  rw [hsum, gaussInt_sum]
  simp only [hterm]
  rw [← Complex.ofReal_sum, Finset.sum_div]
