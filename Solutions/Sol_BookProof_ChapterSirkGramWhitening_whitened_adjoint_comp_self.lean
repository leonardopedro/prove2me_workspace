-- Generated from ChapterSirkGramWhitening.lean — solution of BookProof.ChapterSirkGramWhitening.whitened_adjoint_comp_self
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
open BookProof.ChapterSirkGramWhitening









noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} (w : Fin m → E)
    {T : EuclideanSpace ℂ (Fin m) →L[ℂ] EuclideanSpace ℂ (Fin m)} (hT : IsWhitening w T) :
    (ContinuousLinearMap.adjoint (whitened w T)).comp (whitened w T)
      = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin m)) := by

  rw [whitened, ContinuousLinearMap.adjoint_comp, ← hT, gramOp]
  ext c
  simp
