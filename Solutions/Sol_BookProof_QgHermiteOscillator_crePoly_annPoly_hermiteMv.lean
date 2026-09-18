-- Generated from ChapterQgHermiteOscillatorEsa.lean — solution of BookProof.QgHermiteOscillator.crePoly_annPoly_hermiteMv
import Mathlib
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Theorems.Thm_BookProof_QgHermiteOscillator_sub_add_single_cancel
import Theorems.Thm_BookProof_HermiteProductBasis_annPoly_apply
import Theorems.Thm_BookProof_HermiteProductBasis_crePoly_hermiteMv
import Theorems.Thm_BookProof_HermiteProductBasis_pderiv_hermiteMv
open BookProof.QgHermiteOscillator




open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) :
    crePoly i (annPoly i (hermiteMv a)) = ((a i : ℂ)) • hermiteMv a := by

  rw [annPoly_apply, pderiv_hermiteMv, map_smul, crePoly_hermiteMv]
  rcases Nat.eq_zero_or_pos (a i) with h0 | hpos
  · rw [h0]
    simp
  · rw [sub_add_single_cancel hpos]
