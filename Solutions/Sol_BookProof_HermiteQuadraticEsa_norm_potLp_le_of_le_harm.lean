-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.norm_potLp_le_of_le_harm
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
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
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
open BookProof.HermiteQuadraticEsa















open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {V : Vd d → ℝ} (hVc : Continuous V) (hVb : ExpBounded V)
    {a b : ℝ} (ha : 0 ≤ a) (hb : 0 ≤ b) (hV : ∀ x, |V x| ≤ a * harmW x + b)
    (p : MvPolynomial (Fin d) ℂ) :
    ‖potLp V hVc hVb p‖ ≤ a * ‖pgLp (harmPoly * p)‖ + b * ‖pgLp p‖ := by

  have hstep : ‖potLp V hVc hVb p‖
      ≤ ‖((a : ℝ) : ℂ) • pgLp (harmPoly * p) + ((b : ℝ) : ℂ) • pgLp p‖ := by
    refine Lp.norm_le_norm_of_ae_le ?_
    filter_upwards [potLp_coeFn V hVc hVb p,
      Lp.coeFn_add (((a : ℝ) : ℂ) • pgLp (harmPoly * p)) (((b : ℝ) : ℂ) • pgLp p),
      Lp.coeFn_smul ((a : ℝ) : ℂ) (pgLp (harmPoly * p)),
      Lp.coeFn_smul ((b : ℝ) : ℂ) (pgLp p),
      pgLp_coeFn (harmPoly * p), pgLp_coeFn p] with x h1 h2 h3 h4 h5 h6
    have hfun : pgFun (harmPoly * p) x = ((harmW x : ℝ) : ℂ) * pgFun p x := by
      simp only [pgFun, map_mul, eval_harmPoly]
      ring
    rw [h1, h2, Pi.add_apply, h3, h4, Pi.smul_apply, Pi.smul_apply, h5, h6, hfun,
      smul_eq_mul, smul_eq_mul]
    have hrw : ((a : ℝ) : ℂ) * (((harmW x : ℝ) : ℂ) * pgFun p x) + ((b : ℝ) : ℂ) * pgFun p x
        = ((a * harmW x + b : ℝ) : ℂ) * pgFun p x := by
      push_cast
      ring
    rw [hrw, norm_mul, norm_mul, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs,
      Real.norm_eq_abs]
    refine mul_le_mul_of_nonneg_right ?_ (norm_nonneg _)
    have hpos : 0 ≤ a * harmW x + b := by
      have : 0 ≤ harmW x := by unfold harmW; positivity
      positivity
    rw [abs_of_nonneg hpos]
    exact hV x
  refine hstep.trans ((norm_add_le _ _).trans ?_)
  rw [norm_smul, norm_smul, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs,
    Real.norm_eq_abs, abs_of_nonneg ha, abs_of_nonneg hb]
