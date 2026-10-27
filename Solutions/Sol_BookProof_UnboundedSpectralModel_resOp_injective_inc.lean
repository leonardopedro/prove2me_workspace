-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.resOp_injective_inc
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterSpectralDirectSum
import Definitions.Def_ChapterStoneResolvent
open BookProof.UnboundedSpectralModel



noncomputable section

open MeasureTheory Complex
open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterSpectralDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint H) : Function.Injective (resOp T) := by

  intro y z hyz
  have h1 := op_resOp T y
  have h2 := op_resOp T z
  have hsub : (⟨resOp T y, resOp_mem T y⟩ : T.domain) = ⟨resOp T z, resOp_mem T z⟩ :=
    Subtype.ext hyz
  have h3 : y + Complex.I • resOp T y = z + Complex.I • resOp T z := by
    rw [← h1, ← h2, hsub]
  rw [hyz] at h3
  exact add_right_cancel h3
