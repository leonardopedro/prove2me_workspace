-- Generated from ChapterStoneTheorem.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.ext'
import Mathlib
import Definitions.Def_ChapterStoneTheorem
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution :
    ∀ {G G' : WeakMeasurableUnitaryGroup H}, (∀ t, G.U t = G'.U t) → G = G'
  | ⟨_, _, _, _, _⟩, ⟨_, _, _, _, _⟩, h => by
      simp only [WeakMeasurableUnitaryGroup.mk.injEq]
      exact funext h

end BookProof.ChapterStoneMeasurable

namespace BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint

open BookProof.ChapterStoneMeasurable BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

omit [CompleteSpace H] in
/-- Two unbounded self-adjoint operators with the same domain and the same action agree. -/
theorem ext_prime : ∀ {T S : UnboundedSelfAdjoint H}, T.domain = S.domain →
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
  U
| ⟨_, _, _, _, _⟩, ⟨_, _, _, _, _⟩, h => by
      simp only [WeakMeasurableUnitaryGroup.mk.injEq]
      exact funext h
