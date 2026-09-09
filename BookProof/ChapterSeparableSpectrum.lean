import BookProof.ChapterStandardBorelClassification

/-!
# Separability is exactly metrizability of the spectrum (plan GAP-2, the last residue)

`ChapterStandardBorelClassification` proves the exhaustiveness half of the abelian
von Neumann classification — every summand of the general abelian multiplication model
realises one of the manuscript's five standard types — under one standing hypothesis:
the compact space `Y` carrying the model (the spectrum) is **metrizable**.  This module
removes the hypothesis from the list of unexplained assumptions by identifying it with
a purely algebraic condition and by discharging it in the standard setting.

* `metrizableSpace_of_separable_continuousMap` — a compact Hausdorff space whose
  algebra `C(Y, ℂ)` is *separable* is metrizable.  The proof is the classical one:
  a countable dense family of continuous functions separates points (Urysohn), so it
  embeds `Y` into a countable power of `ℂ`, and a continuous injection out of a compact
  space into a Hausdorff space is an embedding;
* `separableSpace_continuousMap_of_metrizable` — the converse;
* `metrizableSpace_iff_separableSpace_continuousMap` — hence, for a compact Hausdorff
  spectrum, *metrizability of the spectrum and separability of the algebra are the same
  hypothesis*;
* `metrizableSpace_characterSpace` — via Gelfand duality, the character space of a
  **separable** commutative unital C\*-algebra is metrizable;
* **HEADLINE** `abelian_multiplication_model_classified_separable` and
  `abelian_algebra_multiplication_model_classified` — the classification list with the
  metrizability hypothesis replaced by separability of the algebra: every unital
  `*`-representation of a separable commutative unital C\*-algebra on a complex Hilbert
  space is a direct sum of multiplication algebras, each of which realises one of the
  five standard types.

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

open MeasureTheory TopologicalSpace WeakDual

namespace BookProof.ChapterSeparableSpectrum

open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianDirectSum
open BookProof.ChapterStandardBorelClassification

/-! ## 1. Separability of the algebra ⇔ metrizability of the spectrum -/

section Spectrum

variable (Y : Type*) [TopologicalSpace Y] [CompactSpace Y] [T2Space Y]

/-- A countable dense family of continuous functions separates the points of a compact
Hausdorff space: two points not separated by the family are not separated by any
continuous function, and Urysohn's lemma separates distinct points. -/
theorem eq_of_forall_dense_apply_eq {D : Set C(Y, ℂ)} (hD : Dense D) {y₁ y₂ : Y}
    (h : ∀ d ∈ D, (d : C(Y, ℂ)) y₁ = d y₂) : y₁ = y₂ := by
  have hsep : ∀ f : C(Y, ℂ), f y₁ = f y₂ := by
    intro f
    have key : ∀ ε : ℝ, 0 < ε → dist (f y₁) (f y₂) < 2 * ε := by
      intro ε hε
      obtain ⟨d, hdD, hd⟩ := Metric.mem_closure_iff.1 (hD f) ε hε
      have h1 : dist (f y₁) (d y₁) < ε :=
        lt_of_le_of_lt (ContinuousMap.dist_apply_le_dist y₁) hd
      have h2 : dist (f y₂) (d y₂) < ε :=
        lt_of_le_of_lt (ContinuousMap.dist_apply_le_dist y₂) hd
      calc dist (f y₁) (f y₂) ≤ dist (f y₁) (d y₁) + dist (d y₂) (f y₂) := by
            rw [h d hdD]; exact dist_triangle _ _ _
        _ < ε + ε := by rw [dist_comm (d y₂)]; exact add_lt_add h1 h2
        _ = 2 * ε := by ring
    have hle : dist (f y₁) (f y₂) ≤ 0 := by
      by_contra hlt
      push_neg at hlt
      have := key (dist (f y₁) (f y₂) / 4) (by linarith)
      linarith
    exact dist_eq_zero.1 (le_antisymm hle dist_nonneg)
  by_contra hne
  obtain ⟨g, hg0, hg1, -⟩ := exists_continuous_zero_one_of_isClosed
    (isClosed_singleton (x := y₁)) (isClosed_singleton (x := y₂))
    (by simpa [Set.disjoint_singleton] using hne)
  have := hsep (ContinuousMap.mk (fun y => (g y : ℂ)) (by fun_prop))
  simp [hg0 rfl, hg1 rfl] at this

/-- **A compact Hausdorff space with a separable algebra of continuous functions is
metrizable.**  A countable dense family `{fₙ}` embeds `Y` into `ℂ^ℕ`. -/
theorem metrizableSpace_of_separable_continuousMap [SeparableSpace C(Y, ℂ)] :
    MetrizableSpace Y := by
  obtain ⟨D, hDcount, hDdense⟩ := exists_countable_dense C(Y, ℂ)
  haveI : Countable D := hDcount.to_subtype
  set F : Y → (D → ℂ) := fun y d => (d : C(Y, ℂ)) y with hF
  have hcont : Continuous F := continuous_pi fun d => (d : C(Y, ℂ)).continuous
  have hinj : Function.Injective F := by
    intro y₁ y₂ h
    exact eq_of_forall_dense_apply_eq Y hDdense fun d hd => congrFun h ⟨d, hd⟩
  exact (hcont.isClosedEmbedding hinj).isEmbedding.metrizableSpace

omit [T2Space Y] in
/-- The converse: on a compact metrizable space the algebra of continuous functions is
separable (the Stone–Weierstrass side of the equivalence, available in Mathlib through
second countability of the compact-open topology). -/
theorem separableSpace_continuousMap_of_metrizable [MetrizableSpace Y] :
    SeparableSpace C(Y, ℂ) := by
  letI := metrizableSpaceMetric Y
  haveI : SecondCountableTopology Y := UniformSpace.secondCountable_of_separable Y
  infer_instance

/-- **Metrizability of the spectrum is separability of the algebra.**  So the standing
hypothesis of the exhaustiveness theorem is not a topological accident: it says exactly
that the abelian algebra is norm-separable. -/
theorem metrizableSpace_iff_separableSpace_continuousMap :
    MetrizableSpace Y ↔ SeparableSpace C(Y, ℂ) :=
  ⟨fun _ => separableSpace_continuousMap_of_metrizable Y,
    fun _ => metrizableSpace_of_separable_continuousMap Y⟩

end Spectrum

/-! ## 2. The classification with separability in place of metrizability -/

section SeparableModel

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y]
  [SeparableSpace C(Y, ℂ)] [MeasurableSpace Y] [BorelSpace Y]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-- **HEADLINE.**  The exhaustiveness theorem with the metrizability hypothesis replaced
by separability of the algebra: every abelian algebra of operators presented as a unital
`*`-representation of a *separable* `C(Y, ℂ)` is a direct sum of multiplication algebras,
each of which realises one of the five standard types. -/
theorem abelian_multiplication_model_classified_separable (pi : C(Y, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) :
    ∃ (S : Set H) (mu : S → Measure Y) (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (g : C(Y, ℂ)) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) g u) = pi g (V x u)) ∧
      (∀ x : S, ∃ _ : IsProbabilityMeasure (mu x), RealizesStandardType (mu x)) := by
  haveI : MetrizableSpace Y := metrizableSpace_of_separable_continuousMap Y
  exact abelian_multiplication_model_classified pi

end SeparableModel

/-! ## 3. The Gelfand form: a separable commutative C*-algebra -/

section GelfandSeparable

variable (A : Type*) [CommCStarAlgebra A]

/-- Gelfand duality transports separability of the algebra to separability of the
algebra of continuous functions on its character space. -/
theorem separableSpace_continuousMap_characterSpace [SeparableSpace A] :
    SeparableSpace C(characterSpace ℂ A, ℂ) :=
  ((gelfandModel A).surjective.denseRange).separableSpace
    (gelfandModel_isometry A).continuous

/-- **The character space of a separable commutative unital C\*-algebra is
metrizable** — hence a compact metric, so standard Borel, space. -/
theorem metrizableSpace_characterSpace [SeparableSpace A] :
    MetrizableSpace (characterSpace ℂ A) := by
  haveI := separableSpace_continuousMap_characterSpace A
  exact metrizableSpace_of_separable_continuousMap _

variable {A}
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-- **HEADLINE (exhaustiveness for a separable abelian C\*-algebra).**  Every unital
`*`-representation `ρ` of a *separable* commutative unital C\*-algebra `A` on a complex
Hilbert space is a direct sum of multiplication representations — `ρ(a)` acts on the
summand `L²(μₓ)` as multiplication by the Gelfand transform of `a` — and **each summand
realises one of the five standard types** of the abelian classification list.  No
metrizability of the spectrum is assumed here: separability of `A` supplies it. -/
theorem abelian_algebra_multiplication_model_classified [SeparableSpace A]
    (rho : A →⋆ₐ[ℂ] (H →L[ℂ] H)) :
    ∃ (S : Set H) (mu : S → Measure (characterSpace ℂ A))
      (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (a : A) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) (gelfandModel A a) u) = rho a (V x u)) ∧
      (∀ x : S, ∃ _ : IsProbabilityMeasure (mu x), RealizesStandardType (mu x)) := by
  haveI : MetrizableSpace (characterSpace ℂ A) := metrizableSpace_characterSpace A
  letI := metrizableSpaceMetric (characterSpace ℂ A)
  haveI : PolishSpace (characterSpace ℂ A) := inferInstance
  haveI : StandardBorelSpace (characterSpace ℂ A) := inferInstance
  obtain ⟨S, mu, V, hprob, hsum, hint⟩ := abelian_algebra_multiplication_model_general rho
  refine ⟨S, mu, V, hprob, hsum, hint, fun x => ?_⟩
  haveI := hprob x
  exact ⟨hprob x, standardBorel_classification_list (mu x)⟩

end GelfandSeparable

end BookProof.ChapterSeparableSpectrum

end
