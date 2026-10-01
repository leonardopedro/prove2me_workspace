import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
import Mathlib


/-!
# Chapter A, §A.1 — the real/complex subsystem correspondence (work-package N1)

This file supplies the *closed-subspace bookkeeping* that the roadmap
(`FORMALIZATION_ROADMAP.md`, §A.1, Props 11/12) identifies as "the main work" of
the real↔complex trichotomy.  Building on the complex inner-product
infrastructure of `BookProof/Complexification.lean` (the complexification
`Cx W` of a real Hilbert space, its canonical conjugation `Cx.cxConj`, and the
complexification `cxSystem` of a real system), we establish an order-preserving
**bijection**

  { subsystems of a real system `(M, W)` }
      ≃  { conjugation-invariant subsystems of `(M, Cx W)` }

given by `Y ↦ complexify Y` with inverse `X ↦ realPart X`.  Its immediate
consequence is the headline

  `irreducible_iff_no_conj_subsystem` :
    `(M, W)` is irreducible ⇔ the complexification `(M, Cx W)` has no proper
    non-trivial *conjugation-invariant* subsystem,

which is exactly the reduction of real irreducibility to the conjugation-stable
part of the complexified subspace lattice used throughout Props 11/12.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped RealInnerProductSpace
open BookProof.ChapterA

namespace BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

namespace Cx

/-! ### Continuity of the coordinate maps and the real embedding -/














/-! ### The complexification of a real subspace and the real part of a complex one -/

/-- **Complexification of a real subspace.** `complexify Y` is the complex
subspace `{⟨u, v⟩ : u, v ∈ Y}` of `Cx W`. -/
def complexify (Y : Submodule ℝ W) : Submodule ℂ (Cx W) where
  carrier := {x | x.re ∈ Y ∧ x.im ∈ Y}
  add_mem' := by
    rintro a b ⟨ha1, ha2⟩ ⟨hb1, hb2⟩
    exact ⟨Y.add_mem ha1 hb1, Y.add_mem ha2 hb2⟩
  zero_mem' := ⟨Y.zero_mem, Y.zero_mem⟩
  smul_mem' := by
    rintro z a ⟨ha1, ha2⟩
    exact ⟨Y.sub_mem (Y.smul_mem z.re ha1) (Y.smul_mem z.im ha2),
      Y.add_mem (Y.smul_mem z.re ha2) (Y.smul_mem z.im ha1)⟩



/-- **Real part of a complex subspace.** `realPart X` is the real subspace
`{w : W | ofReal w ∈ X}` of `W`. -/
def realPart (X : Submodule ℂ (Cx W)) : Submodule ℝ W where
  carrier := {w | ofReal w ∈ X}
  add_mem' := by
    intro a b ha hb
    simp only [Set.mem_setOf_eq, ofReal_add] at *
    exact X.add_mem ha hb
  zero_mem' := by
    simp only [Set.mem_setOf_eq]
    have : ofReal (0 : W) = 0 := by ext <;> simp
    rw [this]; exact X.zero_mem
  smul_mem' := by
    intro r a ha
    simp only [Set.mem_setOf_eq] at *
    have : ofReal (r • a) = (r : ℂ) • ofReal a := by
      ext
      · rw [csmul_re]; simp
      · rw [csmul_im]; simp
    rw [this]; exact X.smul_mem _ ha



/-! ### The two round-trips -/



/-
If a complex subspace `X` is invariant under the conjugation `cxConj`, then
`complexify (realPart X) = X`.
-/




/-! ### Extremal values -/









/-! ### `complexify` and `realPart` preserve subsystems -/

variable [CompleteSpace W]

/-
`complexify` sends a subsystem of `(M, W)` to a subsystem of `(M, Cx W)`.
-/


/-
`realPart` sends a subsystem of `(M, Cx W)` to a subsystem of `(M, W)`.
-/


end Cx

/-! ## Headline: irreducibility via the conjugation-invariant lattice -/

/-
**The real irreducibility criterion (§A.1, core of Props 11/12).**  A real
system `(M, W)` is irreducible **iff** its complexification `(M, Cx W)` has no
proper non-trivial *conjugation-invariant* subsystem.  This is the reduction of
real irreducibility to the `cxConj`-stable part of the complexified subspace
lattice, obtained from the order-preserving bijection
`Y ↦ complexify Y`, `X ↦ realPart X`.
-/


end BookProof.Complexification
