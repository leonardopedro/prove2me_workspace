-- Generated from ChapterQgHermiteOscillatorEsa.lean — solution of BookProof.QgHermiteOscillator.harmCore_pgLp
import Mathlib
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Theorems.Thm_BookProof_QgHermiteOscillator_potLp_harmW
import Theorems.Thm_BookProof_QgHermiteFriedrichs_hamCore_pgLp
open BookProof.QgHermiteOscillator




open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin d) ℂ) :
    harmCore ⟨pgLp p, pgLp_mem_core p⟩ = pgLp (kinPoly p + harmPoly * p) := by

  unfold harmCore
  rw [hamCore_pgLp]
  unfold hamPoly
  rw [potLp_harmW]
  exact (map_add (pgMap (d := d)) (kinPoly p) (harmPoly * p)).symm
