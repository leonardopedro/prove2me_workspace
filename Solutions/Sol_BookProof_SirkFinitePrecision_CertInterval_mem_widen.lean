-- Generated from ChapterSirkFinitePrecision.lean — solution of BookProof.SirkFinitePrecision.CertInterval.mem_widen
import Mathlib
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval







noncomputable section


open scoped InnerProductSpace
open Finset

variable {n : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {I : CertInterval} {x ε : ℝ} (hx : I.Mem x) (hε : 0 ≤ ε) :
    (I.widen ε).Mem x := ⟨by simp only [widen]; linarith [hx.1], by simp only [widen]; linarith [hx.2]⟩
