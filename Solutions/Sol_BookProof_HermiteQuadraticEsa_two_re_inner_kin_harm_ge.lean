-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.two_re_inner_kin_harm_ge
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_HermiteQuadraticEsa_gaussInt_self
import Theorems.Thm_BookProof_HermiteQuadraticEsa_gaussInt_harm_self
import Theorems.Thm_BookProof_HermiteQuadraticEsa_gaussInt_anticommutator
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
theorem solution (p : MvPolynomial (Fin d) ℂ) :
    -((d : ℝ) / 2) * ‖pgLp p‖ ^ 2
      ≤ 2 * (inner ℂ (pgLp (kinPoly p)) (pgLp (harmPoly * p)) : ℂ).re := by

  set A : ℂ := (inner ℂ (pgLp (kinPoly p)) (pgLp (harmPoly * p)) : ℂ) with hAdef
  set R : ℝ := ∑ j : Fin d, (∑ k : Fin d, ‖pgLp (X k * coreD j p)‖ ^ 2) / 4 with hRdef
  have hR : 0 ≤ R := by
    rw [hRdef]; positivity
  have hA : A = gaussInt (cpoly (kinPoly p) * (harmPoly * p)) := inner_pgLp_pgLp _ _
  have hB : (inner ℂ (pgLp (harmPoly * p)) (pgLp (kinPoly p)) : ℂ)
      = gaussInt (cpoly (harmPoly * p) * kinPoly p) := inner_pgLp_pgLp _ _
  have hconj : gaussInt (cpoly (harmPoly * p) * kinPoly p) = (starRingEnd ℂ) A := by
    rw [← hB, hAdef, inner_conj_symm]
  have key := gaussInt_anticommutator p
  rw [← hA, hconj, Complex.add_conj, gaussInt_self] at key
  simp only [gaussInt_harm_self] at key
  have hcast :
      (2 : ℂ) * (∑ j : Fin d, (((∑ k : Fin d, ‖pgLp (X k * coreD j p)‖ ^ 2) / 4 : ℝ) : ℂ))
        - ((d : ℂ) / 2) * ((‖pgLp p‖ ^ 2 : ℝ) : ℂ)
      = (((2 * R - (d : ℝ) / 2 * ‖pgLp p‖ ^ 2 : ℝ)) : ℂ) := by
    rw [hRdef]
    push_cast
    ring
  rw [hcast] at key
  have hreal : 2 * A.re = 2 * R - (d : ℝ) / 2 * ‖pgLp p‖ ^ 2 := by exact_mod_cast key
  linarith
