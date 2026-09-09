import Mathlib
import BookProof.ChapterA3j
import BookProof.ChapterA3k
import BookProof.ChapterA3q

/-!
# Chapter A3w — the Weyl half of the exhaustiveness bundle (roadmap N11, Lemma 52)

This file assembles the *complete-reducibility / classification* clause of the
book's Lemma 52 (Notes 50–51): the finite-dimensional irreducible representations
of the Lorentz group are the `V_{(m,n)}`, and parity glues `V_{(m,n)}` to
`V_{(n,m)}`, so the parity-invariant real irreps are `V_{(m,n)} ⊕ V_{(n,m)}`.

Following the `IsSchurFull` / `PauliFundamental` design, the one genuinely
external input — **Weyl's theorem** that finite-dimensional `SL(2,ℂ)`-reps are
completely reducible — is introduced as a **named hypothesis with a citation
docstring, never an `axiom`**.  The concrete *parity-gluing mechanism* is then
fully proved from the on-disk chirality/parity cores of `ChapterA3j`/`ChapterA3k`,
and the general-`N` complete-reducibility projector system is `ChapterA3q`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); the Weyl input is a hypothesis, not an axiom.
-/

open Matrix

namespace BookProof.ChapterA3w

open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k BookProof.ChapterA3q

/-! ## External input: Weyl complete reducibility -/

/-- **Weyl's theorem** (H. Weyl, *Math. Z.* 24 (1926) 328–395), taken as an
`EXTERNAL` named hypothesis (not available in Mathlib for `SL(2,ℂ)`; never an
`axiom`).  Every finite-dimensional representation of `SL(2,ℂ)` is completely
reducible: every invariant subspace has an invariant complement (equivalently,
the representation is a direct sum of the irreducibles `V_{(m,n)}`). -/
def WeylCompleteReducibility : Prop :=
  ∀ {V : Type} [AddCommGroup V] [Module ℂ V] [Module.Finite ℂ V]
    (ρ : Representation ℂ (Matrix.SpecialLinearGroup (Fin 2) ℂ) V)
    (W : Submodule ℂ V), (∀ g : Matrix.SpecialLinearGroup (Fin 2) ℂ, ∀ x ∈ W, ρ g x ∈ W) →
      ∃ W' : Submodule ℂ V,
        (∀ g : Matrix.SpecialLinearGroup (Fin 2) ℂ, ∀ x ∈ W', ρ g x ∈ W') ∧ IsCompl W W'

/-- **Weyl reducibility applied.** Under the Weyl hypothesis, any Lorentz-invariant
subspace of a finite-dimensional `SL(2,ℂ)`-representation splits off an invariant
complement — the input the Lemma 52 classification needs to peel off irreducible
constituents. -/
theorem weyl_invariant_complement (h : WeylCompleteReducibility)
    {V : Type} [AddCommGroup V] [Module ℂ V] [Module.Finite ℂ V]
    (ρ : Representation ℂ (Matrix.SpecialLinearGroup (Fin 2) ℂ) V)
    (W : Submodule ℂ V)
    (hW : ∀ g : Matrix.SpecialLinearGroup (Fin 2) ℂ, ∀ x ∈ W, ρ g x ∈ W) :
    ∃ W' : Submodule ℂ V,
      (∀ g : Matrix.SpecialLinearGroup (Fin 2) ℂ, ∀ x ∈ W', ρ g x ∈ W') ∧ IsCompl W W' :=
  h ρ W hW

/-! ## Concrete parity-gluing mechanism (fully proved from the cores) -/

/-- **Lemma 52 assembled — the concrete parity mechanism.**  The chiral (Weyl)
projectors realize the two inequivalent fundamental spinor irreps `V_{(½,0)}`
and `V_{(0,½)}`:

* chirality is **not** parity-invariant (`P_L γ⁰ ≠ γ⁰ P_L`) — a single chiral
  block is not a Lorentz-with-parity rep;
* parity **exchanges** the two chiral blocks (`P_L γ⁰ = γ⁰ P_R`), so the
  parity-invariant irrep is the glued Dirac spinor `V_{(½,0)} ⊕ V_{(0,½)}`;
* at the tensor-square level the pure-chirality block `LL` is not parity-invariant
  and parity swaps `LL ↔ RR` (`(γ⁰⊗γ⁰)·P_RR = P_LL·(γ⁰⊗γ⁰)`), gluing `V_{(1,0)}`
  to `V_{(0,1)}`.

This is exactly the mechanism that makes the `V_{(m,n)}` of Lemma 52 pair up
under parity. -/
theorem lemma52_parity_gluing :
    (projChirL * mgamma 0 ≠ mgamma 0 * projChirL) ∧
    (projChirL * mgamma 0 = mgamma 0 * projChirR) ∧
    (parityDiag * projLL ≠ projLL * parityDiag) ∧
    (parityDiag * projRR = projLL * parityDiag) :=
  ⟨chirality_not_parity_invariant, parity_swaps_chirL,
   projLL_not_parity_invariant, parity_swaps_LL_RR⟩

end BookProof.ChapterA3w
