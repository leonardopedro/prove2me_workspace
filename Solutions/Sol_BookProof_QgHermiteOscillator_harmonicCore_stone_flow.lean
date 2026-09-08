-- Generated from ChapterQgHermiteOscillatorEsa.lean — solution of BookProof.QgHermiteOscillator.harmonicCore_stone_flow
import Mathlib
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Theorems.Thm_BookProof_QgHermiteOscillator_harmonicCore_essentiallySelfAdjoint
import Theorems.Thm_BookProof_QgHermiteOscillator_harmonicCore_dense
import Theorems.Thm_BookProof_QgHermiteOscillator_harmonicCore_symmetricOn
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
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (harmCore (d := d)) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa harmCore harmonicCore_dense harmonicCore_symmetricOn
      harmonicCore_essentiallySelfAdjoint
