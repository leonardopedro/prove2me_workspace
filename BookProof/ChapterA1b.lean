import Mathlib
import BookProof.ChapterA
import BookProof.ChapterA1
import BookProof.Complexification

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

/-- The real-part projection `Cx W → W` is Lipschitz (hence continuous). -/
lemma lipschitz_re : LipschitzWith 1 (Cx.re : Cx W → W) := by
  refine LipschitzWith.of_dist_le_mul (fun x y => ?_)
  simp only [NNReal.coe_one, one_mul, dist_eq_norm]
  calc ‖x.re - y.re‖ = ‖(x - y).re‖ := by rw [sub_re]
    _ ≤ ‖x - y‖ := norm_re_le _

/-- The imaginary-part projection `Cx W → W` is Lipschitz (hence continuous). -/
lemma lipschitz_im : LipschitzWith 1 (Cx.im : Cx W → W) := by
  refine LipschitzWith.of_dist_le_mul (fun x y => ?_)
  simp only [NNReal.coe_one, one_mul, dist_eq_norm]
  calc ‖x.im - y.im‖ = ‖(x - y).im‖ := by rw [sub_im]
    _ ≤ ‖x - y‖ := norm_im_le _

lemma continuous_re : Continuous (Cx.re : Cx W → W) := lipschitz_re.continuous
lemma continuous_im : Continuous (Cx.im : Cx W → W) := lipschitz_im.continuous

/-- The real embedding `ofReal : W → Cx W` is an isometry (hence continuous). -/
lemma continuous_ofReal : Continuous (Cx.ofReal : W → Cx W) := by
  refine LipschitzWith.continuous (K := 1) ?_
  refine LipschitzWith.of_dist_le_mul (fun x y => ?_)
  simp only [NNReal.coe_one, one_mul, dist_eq_norm]
  have : ofReal x - ofReal y = ofReal (x - y) := by ext <;> simp
  rw [this]
  rw [← Real.sqrt_sq (norm_nonneg (ofReal (x - y))), ← Real.sqrt_sq (norm_nonneg (x - y))]
  rw [norm_sq]; simp

lemma ofReal_eq_zero {w : W} : ofReal w = 0 ↔ w = 0 := by
  constructor
  · intro h; have := congrArg Cx.re h; simpa using this
  · rintro rfl; ext <;> simp

/-- Every vector decomposes as `x = ofReal x.re + i · ofReal x.im`. -/
lemma eq_ofReal_add_smul (x : Cx W) : x = ofReal x.re + (Complex.I : ℂ) • ofReal x.im := by
  rw [smul_I]; ext <;> simp

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

@[simp] lemma mem_complexify {Y : Submodule ℝ W} {x : Cx W} :
    x ∈ complexify Y ↔ x.re ∈ Y ∧ x.im ∈ Y := Iff.rfl

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

@[simp] lemma mem_realPart {X : Submodule ℂ (Cx W)} {w : W} :
    w ∈ realPart X ↔ ofReal w ∈ X := Iff.rfl

/-! ### The two round-trips -/

/-- `realPart (complexify Y) = Y`. -/
@[simp] lemma realPart_complexify (Y : Submodule ℝ W) : realPart (complexify Y) = Y := by
  ext w
  simp only [mem_realPart, mem_complexify, ofReal_re, ofReal_im]
  constructor
  · rintro ⟨h, _⟩; exact h
  · intro h; exact ⟨h, Y.zero_mem⟩

/-
If a complex subspace `X` is invariant under the conjugation `cxConj`, then
`complexify (realPart X) = X`.
-/
lemma complexify_realPart_of_invariant {X : Submodule ℂ (Cx W)}
    (hX : ∀ x ∈ X, cxConj x ∈ X) : complexify (realPart X) = X := by
  refine le_antisymm ?_ ?_
  · -- `complexify (realPart X) ⊆ X`
    rw [SetLike.le_def]
    rintro x ⟨hxre, hxim⟩
    rw [eq_ofReal_add_smul x]
    exact X.add_mem hxre (X.smul_mem _ hxim)
  · -- `X ⊆ complexify (realPart X)`
    rw [SetLike.le_def]
    intro x hx
    refine ⟨?_, ?_⟩
    · -- `ofReal x.re = ½ (x + cxConj x) ∈ X`
      change ofReal x.re ∈ X
      have h : ofReal x.re = (2⁻¹ : ℂ) • (x + cxConj x) := by
        ext
        · simp [cxConj_apply, csmul_re]; module
        · simp [cxConj_apply, csmul_im]
      rw [h]; exact X.smul_mem _ (X.add_mem hx (hX x hx))
    · -- `ofReal x.im = (-½ i) (x - cxConj x) ∈ X`
      change ofReal x.im ∈ X
      have h : ofReal x.im = (-(2⁻¹ : ℂ) * Complex.I) • (x - cxConj x) := by
        ext
        · simp [cxConj_apply, csmul_re, Complex.mul_re, Complex.mul_im]; module
        · simp [cxConj_apply, csmul_im, Complex.mul_re, Complex.mul_im]
      rw [h]; exact X.smul_mem _ (X.sub_mem hx (hX x hx))

/-- `complexify Y` is always invariant under the conjugation. -/
lemma complexify_cxConj_invariant (Y : Submodule ℝ W) :
    ∀ x ∈ complexify Y, cxConj x ∈ complexify Y := by
  intro x hx
  simp only [mem_complexify, cxConj_apply] at *
  exact ⟨hx.1, Y.neg_mem hx.2⟩

/-! ### Extremal values -/

@[simp] lemma complexify_bot : complexify (⊥ : Submodule ℝ W) = ⊥ := by
  ext x
  simp only [mem_complexify, Submodule.mem_bot]
  constructor
  · rintro ⟨h1, h2⟩; ext <;> simp [h1, h2]
  · rintro rfl; exact ⟨rfl, rfl⟩

@[simp] lemma complexify_top : complexify (⊤ : Submodule ℝ W) = ⊤ := by
  ext x; simp

@[simp] lemma realPart_bot : realPart (⊥ : Submodule ℂ (Cx W)) = ⊥ := by
  ext w
  simp only [mem_realPart, Submodule.mem_bot, ofReal_eq_zero]

@[simp] lemma realPart_top : realPart (⊤ : Submodule ℂ (Cx W)) = ⊤ := by
  ext w; simp

/-! ### `complexify` and `realPart` preserve subsystems -/

variable [CompleteSpace W]

/-
`complexify` sends a subsystem of `(M, W)` to a subsystem of `(M, Cx W)`.
-/
lemma complexify_isSubsystem (M : System ℝ W) {Y : Submodule ℝ W}
    (hY : (M).IsSubsystem Y) : (cxSystem M).IsSubsystem (complexify Y) := by
  refine ⟨?_, ?_⟩
  · convert IsClosed.inter (hY.1.preimage continuous_re) (hY.1.preimage continuous_im) using 1
  · rintro _ ⟨m, hm, rfl⟩ w hw
    exact ⟨by simpa [cxMap_apply] using hY.2 m hm w.re hw.1,
      by simpa [cxMap_apply] using hY.2 m hm w.im hw.2⟩

/-
`realPart` sends a subsystem of `(M, Cx W)` to a subsystem of `(M, W)`.
-/
lemma realPart_isSubsystem (M : System ℝ W) {X : Submodule ℂ (Cx W)}
    (hX : (cxSystem M).IsSubsystem X) : (M).IsSubsystem (realPart X) := by
  obtain ⟨hX_closed, hX_inv⟩ := hX
  refine ⟨?_, ?_⟩
  · convert hX_closed.preimage continuous_ofReal using 1
  · intro m hm w hw
    have hmap : cxMap m (ofReal w) = ofReal (m w) := by
      ext <;> simp [ofReal]
    have := hX_inv _ (Set.mem_image_of_mem _ hm) _ hw
    simpa [hmap] using this

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
theorem irreducible_iff_no_conj_subsystem [CompleteSpace W] (M : System ℝ W) :
    M.IsIrreducible ↔
      ∀ X : Submodule ℂ (Cx W), (cxSystem M).IsSubsystem X →
        (∀ x ∈ X, Cx.cxConj x ∈ X) → X = ⊥ ∨ X = ⊤ := by
  constructor
  · -- real irreducible ⇒ no proper conjugation-invariant complex subsystem
    intro hirr X hX hXinv
    rcases hirr _ (Cx.realPart_isSubsystem M hX) with h | h
    · exact Or.inl <| by
        rw [← Cx.complexify_realPart_of_invariant hXinv, h, Cx.complexify_bot]
    · exact Or.inr <| by
        rw [← Cx.complexify_realPart_of_invariant hXinv, h, Cx.complexify_top]
  · -- the converse, via the round-trip `realPart (complexify Y) = Y`
    intro h Y hY
    rcases h (Cx.complexify Y) (Cx.complexify_isSubsystem M hY)
        (Cx.complexify_cxConj_invariant Y) with h | h
    · refine Or.inl ?_
      have := congrArg Cx.realPart h
      rwa [Cx.realPart_complexify, Cx.realPart_bot] at this
    · refine Or.inr ?_
      have := congrArg Cx.realPart h
      rwa [Cx.realPart_complexify, Cx.realPart_top] at this

end BookProof.Complexification
