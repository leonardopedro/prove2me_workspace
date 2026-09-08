-- Generated from ChapterQgHermiteOscillatorEsa.lean — solution of BookProof.QgHermiteOscillator.harmonicCore_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Theorems.Thm_BookProof_QgHermiteOscillator_essentiallySelfAdjointOn_of_eigenbasis
import Theorems.Thm_BookProof_QgHermiteOscillator_harmCore_hermiteMvLp
open BookProof.QgHermiteOscillator












open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  {ι : Type*} {D : Submodule ℂ F}





variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) harmCore := by

  refine essentiallySelfAdjointOn_of_eigenbasis harmCore hermiteMvBasis
    (fun a => (mvDeg a : ℝ) + (d : ℝ) / 2) (fun a => by
      rw [hermiteMvBasis_apply]; exact hermiteMvLp_mem_core a) fun a => ?_
  have := harmCore_hermiteMvLp (d := d) a
  simpa using this
