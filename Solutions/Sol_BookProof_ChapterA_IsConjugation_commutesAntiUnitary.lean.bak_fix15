-- Generated from ChapterA1c.lean — solution of BookProof.ChapterA.IsConjugation.commutesAntiUnitary
import Mathlib
import Definitions.Def_ChapterA1c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℂ V} {θ : AntiUnitary V}
    (h : IsConjugation M θ) : CommutesAntiUnitary M θ := h.2
