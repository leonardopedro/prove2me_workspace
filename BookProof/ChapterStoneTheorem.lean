import Mathlib
import BookProof.ChapterStoneConverse

/-!
# The general Stone theorem on a separable Hilbert space

This file assembles the two halves of Stone's theorem proved in
`ChapterStoneResolvent`–`ChapterStoneConverse` into a single statement.

* **Forward direction.**  Every unbounded self-adjoint operator `A` (with dense domain)
  on a complex Hilbert space generates a one-parameter unitary group `e^{-itA}`
  (`UnboundedSelfAdjoint.stoneGroup`), which is even strongly continuous, hence weakly
  measurable, and solves the Schrödinger equation on the domain of `A`.
* **Converse direction.**  On a *separable* Hilbert space, every weakly measurable
  one-parameter unitary group `U` is of this form: its infinitesimal generator `A` is
  self-adjoint and `U t = e^{-itA}` (`WeakMeasurableUnitaryGroup.gen_stoneU_eq`).
* **Uniqueness.**  The generator of `e^{-itA}` is again `A`
  (`UnboundedSelfAdjoint.gen_stoneGroup_eq`), so the two constructions are mutually
  inverse (`BookProof.ChapterStoneTheorem.stone_bijection`).
-/

open scoped InnerProductSpace

namespace BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

/-- A weakly measurable unitary group is determined by the family of operators. -/
theorem WeakMeasurableUnitaryGroup.ext' :
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
theorem ext' : ∀ {T S : UnboundedSelfAdjoint H}, T.domain = S.domain →
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
  U := T.stoneU
  map_zero := T.stoneU_zero
  map_add := T.stoneU_add
  norm_map := T.norm_stoneU_apply
  weaklyMeasurable := fun x y => T.measurable_inner_stoneU x y

@[simp] theorem stoneGroup_U (T : UnboundedSelfAdjoint H) (t : ℝ) :
    T.stoneGroup.U t = T.stoneU t := rfl

/-! ## The generator of `e^{-itA}` is `A` -/

/-- The domain of `A` is contained in the domain of the generator of `e^{-itA}`. -/
theorem domain_le_genDomain (T : UnboundedSelfAdjoint H) :
    T.domain ≤ T.stoneGroup.genDomain := fun x hx =>
  T.stoneGroup.mem_genDomain_of_hasDerivAt (T.hasDerivAt_stoneU_zero ⟨x, hx⟩)

/-- On the domain of `A`, the generator of `e^{-itA}` acts as `A`. -/
theorem genOp_eq_op (T : UnboundedSelfAdjoint H) (x : T.domain) :
    T.stoneGroup.genOp ⟨(x : H), T.domain_le_genDomain x.2⟩ = T.op x :=
  T.stoneGroup.genOp_eq_of_hasDerivAt (T.hasDerivAt_stoneU_zero x)

/-- The domain of the generator of `e^{-itA}` is exactly the domain of `A`: a self-adjoint
operator admits no proper symmetric extension. -/
theorem genDomain_eq_domain (T : UnboundedSelfAdjoint H) :
    T.stoneGroup.genDomain = T.domain := by
  refine le_antisymm ?_ T.domain_le_genDomain
  intro x hx
  refine T.mem_domain_of_inner (eta := T.stoneGroup.genOp ⟨x, hx⟩) ?_
  intro psi
  have hpsi : (psi : H) ∈ T.stoneGroup.genDomain := T.domain_le_genDomain psi.2
  have hsym := T.stoneGroup.symmetric ⟨(psi : H), hpsi⟩ ⟨x, hx⟩
  rw [← T.genOp_eq_op psi]
  exact hsym

variable [TopologicalSpace.SeparableSpace H]

/-- **The generator of `e^{-itA}` is `A`.** -/
theorem gen_stoneGroup_eq (T : UnboundedSelfAdjoint H) : T.stoneGroup.gen = T := by
  refine ext' T.genDomain_eq_domain ?_
  intro x _ hx'
  exact T.genOp_eq_op ⟨x, hx'⟩

end BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint

namespace BookProof.ChapterStoneTheorem

open BookProof.ChapterStoneResolvent BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  [TopologicalSpace.SeparableSpace H]

/-- **The general Stone theorem on a separable Hilbert space.**  The map
`A ↦ (t ↦ e^{-itA})` is a bijection between unbounded self-adjoint operators and weakly
measurable one-parameter unitary groups; its inverse sends a group `U` to its
infinitesimal generator `i (d/dt)|₀ U`. -/
theorem stone_bijection :
    Function.Bijective (fun T : UnboundedSelfAdjoint H => T.stoneGroup) := by
  constructor
  · intro T S h
    have h' : T.stoneGroup = S.stoneGroup := h
    rw [← T.gen_stoneGroup_eq, ← S.gen_stoneGroup_eq, h']
  · exact fun G => ⟨G.gen, WeakMeasurableUnitaryGroup.ext' (fun t => G.gen_stoneU_eq t)⟩

end BookProof.ChapterStoneTheorem
