-- Generated from ChapterStoneTheorem.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.ext'
import Mathlib
import Definitions.Def_ChapterStoneTheorem
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterStoneConverse
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterUnitaryTransport
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneResolvent


open scoped InnerProductSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.ext_prime : ∀ {T S : UnboundedSelfAdjoint H}, T.domain = S.domain →
    (∀ (x : H) (hx : x ∈ T.domain) (hx' : x ∈ S.domain), T.op ⟨x, hx⟩ = S.op ⟨x, hx'⟩) → T = S
  | ⟨_, _, _, _, _⟩, ⟨_, _, _, _, _⟩, hd, ho => by
      subst hd
      simp only [UnboundedSelfAdjoint.mk.injEq, heq_eq_eq, true_and]
      ext x
      exact ho (x : H) x.2 x.2

/-! ## The forward direction: a self-adjoint operator generates a unitary group -/

/-- **Stone's theorem, forward direction.**  A self-adjoint operator `A` generates a
one-parameter unitary group `t ↦ e^{-itA}`, which is weakly measurable (indeed strongly
continuous, see `UnboundedSelfAdjoint.continuous_stoneU_apply`). -/
noncomputable def stoneGroup (T : UnboundedSelfAdjoint H) : WeakMeasurableUnitaryGroup H where
  U := by sorry
