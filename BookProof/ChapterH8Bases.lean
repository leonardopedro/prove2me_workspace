import Mathlib
import BookProof.ChapterH8

/-!
# Chapter H8b — the SIRK nesting hypotheses are realized by Krylov bases

`BookProof/ChapterH8.lean` proves that the Hashimoto SIRK approximation orders
nest, for an abstract pair of isometric embeddings `Vₘ = Vₙ ∘ J`.  This companion
module shows those hypotheses are **not vacuous**: they are met by any pair of
nested orthonormal families, and in particular by the orthonormal Krylov bases the
SIRK method actually builds.

## Deliverables

* `orthonormalEmbedding` / `orthonormalEmbeddingLI` — the isometric embedding
  `EuclideanSpace ℂ (Fin m) →L[ℂ] E` of an orthonormal family, with
  `orthonormalEmbedding_single`, `orthonormalEmbedding_inner`,
  `orthonormalEmbedding_adjoint_comp` (`V∗V = 1`) and `orthonormalEmbedding_range`
  (its range is the span of the family);
* `coordIncl` — the coordinate inclusion along `Fin.castLE`, with
  `coordIncl_single` and `coordIncl_adjoint_comp` (`J∗J = 1`);
* `orthonormalEmbedding_nested` — the factorization `Vₘ = Vₙ ∘ J` for nested
  families, hence the hypothesis-free instances
  `sirk_band_refinement_of_orthonormal` and
  `sirk_compression_submatrix_of_orthonormal`;
* `krylovOrthonormalSeq` — Gram–Schmidt applied to `k ↦ Hᵏ v`; its prefixes are
  orthonormal (`krylovOrthonormal_orthonormal`), nested by construction
  (`krylovOrthonormal_nested`) and span the Krylov subspaces
  (`krylovOrthonormal_span`).  `krylovEmbedding` packages the prefix as an
  isometry with `krylovEmbedding_range = krylovSpan H v n`, and
  `sirk_band_refinement_krylov` is the refinement theorem for the Krylov flag
  itself.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterH8

open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

/-! ## Part 1 — the nesting hypotheses are realized by nested orthonormal bases

The refinement theorems of `ChapterH8` are stated for an abstract pair of
isometric embeddings `Vₘ = Vₙ ∘ J`.  This part shows that the hypotheses are not
vacuous: they are met by *any* pair of nested orthonormal families. -/

section Realization

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

/-- The linear isometry `EuclideanSpace ℂ (Fin m) → E` sending the `i`-th
coordinate vector to `w i`, for an orthonormal family `w`. -/
def orthonormalEmbeddingLI {m : ℕ} (w : Fin m → E) (hw : Orthonormal ℂ w) :
    EuclideanSpace ℂ (Fin m) →ₗᵢ[ℂ] E :=
  LinearMap.isometryOfOrthonormal (((EuclideanSpace.basisFun (Fin m) ℂ).toBasis.constr ℂ) w)
    (v := (EuclideanSpace.basisFun (Fin m) ℂ).toBasis)
    (by simp)
    (by
      have h : ((((EuclideanSpace.basisFun (Fin m) ℂ).toBasis.constr ℂ) w) ∘
          (EuclideanSpace.basisFun (Fin m) ℂ).toBasis) = w := by
        funext i
        simp
      rw [h]
      exact hw)

/-- The Krylov-style embedding `V : EuclideanSpace ℂ (Fin m) →L[ℂ] E` attached to an
orthonormal family `w` (for SIRK: an orthonormal basis of the order-`m` Krylov
subspace). -/
def orthonormalEmbedding {m : ℕ} (w : Fin m → E) (hw : Orthonormal ℂ w) :
    EuclideanSpace ℂ (Fin m) →L[ℂ] E :=
  (orthonormalEmbeddingLI w hw).toContinuousLinearMap

omit [CompleteSpace E] in
/-- The embedding sends the `i`-th coordinate vector to the `i`-th basis vector. -/
theorem orthonormalEmbedding_single {m : ℕ} (w : Fin m → E) (hw : Orthonormal ℂ w) (i : Fin m) :
    orthonormalEmbedding w hw (EuclideanSpace.single i (1 : ℂ)) = w i := by
  simp [orthonormalEmbedding, orthonormalEmbeddingLI, LinearMap.isometryOfOrthonormal,
    LinearIsometry.toContinuousLinearMap]

omit [CompleteSpace E] in
/-- The embedding preserves inner products. -/
theorem orthonormalEmbedding_inner {m : ℕ} (w : Fin m → E) (hw : Orthonormal ℂ w)
    (x y : EuclideanSpace ℂ (Fin m)) :
    inner ℂ (orthonormalEmbedding w hw x) (orthonormalEmbedding w hw y) = inner ℂ x y :=
  (orthonormalEmbeddingLI w hw).inner_map_map x y

/-- **The isometry hypothesis holds**: `V∗ V = 1` for the embedding of an
orthonormal family. -/
theorem orthonormalEmbedding_adjoint_comp {m : ℕ} (w : Fin m → E) (hw : Orthonormal ℂ w) :
    (adjoint (orthonormalEmbedding w hw)).comp (orthonormalEmbedding w hw)
      = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin m)) :=
  ContinuousLinearMap.ext fun x => by
    refine ext_inner_right ℂ fun y => ?_
    rw [ContinuousLinearMap.coe_comp', Function.comp_apply, adjoint_inner_left]
    simpa using orthonormalEmbedding_inner w hw x y

/-- The coordinate inclusion `J : EuclideanSpace ℂ (Fin m) →L[ℂ] EuclideanSpace ℂ (Fin n)`
along `Fin.castLE`, for `m ≤ n`: the concrete `J` of the refinement theorems. -/
def coordIncl {m n : ℕ} (hmn : m ≤ n) :
    EuclideanSpace ℂ (Fin m) →L[ℂ] EuclideanSpace ℂ (Fin n) :=
  orthonormalEmbedding (fun i => EuclideanSpace.single (Fin.castLE hmn i) (1 : ℂ))
    (by
      have h2 := (EuclideanSpace.basisFun (Fin n) ℂ).orthonormal.comp
        (Fin.castLE hmn) (Fin.castLE_injective hmn)
      have h3 : (⇑(EuclideanSpace.basisFun (Fin n) ℂ) ∘ Fin.castLE hmn)
          = fun i => EuclideanSpace.single (Fin.castLE hmn i) (1 : ℂ) := by
        funext i
        simp [EuclideanSpace.basisFun_apply]
      rw [h3] at h2
      exact h2)

/-- The coordinate inclusion acts on coordinate vectors by `Fin.castLE`. -/
theorem coordIncl_single {m n : ℕ} (hmn : m ≤ n) (i : Fin m) :
    coordIncl hmn (EuclideanSpace.single i (1 : ℂ))
      = EuclideanSpace.single (Fin.castLE hmn i) (1 : ℂ) :=
  orthonormalEmbedding_single _ _ i

/-- **The inclusion is isometric**: `J∗ J = 1`. -/
theorem coordIncl_adjoint_comp {m n : ℕ} (hmn : m ≤ n) :
    (adjoint (coordIncl hmn)).comp (coordIncl hmn)
      = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin m)) :=
  orthonormalEmbedding_adjoint_comp _ _

omit [CompleteSpace E] in
/-- **The factorization hypothesis holds**: nested orthonormal families give
embeddings that factor through the coordinate inclusion, `Vₘ = Vₙ ∘ J`. -/
theorem orthonormalEmbedding_nested {m n : ℕ} (hmn : m ≤ n)
    (w : Fin m → E) (w' : Fin n → E) (hw : Orthonormal ℂ w) (hw' : Orthonormal ℂ w')
    (hnest : ∀ i : Fin m, w i = w' (Fin.castLE hmn i)) :
    orthonormalEmbedding w hw = (orthonormalEmbedding w' hw').comp (coordIncl hmn) := by
  refine ContinuousLinearMap.coe_injective ?_
  refine Module.Basis.ext (EuclideanSpace.basisFun (Fin m) ℂ).toBasis fun i => ?_
  have hb : ((EuclideanSpace.basisFun (Fin m) ℂ).toBasis) i
      = EuclideanSpace.single i (1 : ℂ) := by
    simp [EuclideanSpace.basisFun_apply]
  simp only [hb, ContinuousLinearMap.coe_coe, ContinuousLinearMap.coe_comp',
    Function.comp_apply]
  rw [orthonormalEmbedding_single, coordIncl_single, orthonormalEmbedding_single, hnest]

/-- **(c) for nested orthonormal bases.**  With no abstract hypotheses left: for
any two nested orthonormal families (`w i = w' (castLE i)`) whose ranges are
`X`-invariant, the order-`n` approximant of `p(X) v` on the order-`m` data equals
the order-`m` approximant.  Instance of `sirk_band_refinement_poly` with the
concrete `J = coordIncl`. -/
theorem sirk_band_refinement_of_orthonormal {m n : ℕ} (hmn : m ≤ n) (X : E →L[ℂ] E)
    (w : Fin m → E) (w' : Fin n → E) (hw : Orthonormal ℂ w) (hw' : Orthonormal ℂ w')
    (hnest : ∀ i : Fin m, w i = w' (Fin.castLE hmn i))
    (hinvm : ∀ x, ∃ y, X (orthonormalEmbedding w hw x) = orthonormalEmbedding w hw y)
    (hinvn : ∀ x, ∃ y, X (orthonormalEmbedding w' hw' x) = orthonormalEmbedding w' hw' y)
    (p : Polynomial ℂ) (v : E)
    (hv : orthonormalEmbedding w hw ((adjoint (orthonormalEmbedding w hw)) v) = v) :
    orthonormalEmbedding w' hw'
        ((Polynomial.aeval (compress (orthonormalEmbedding w' hw') X) p)
          ((adjoint (orthonormalEmbedding w' hw')) v))
      = orthonormalEmbedding w hw
        ((Polynomial.aeval (compress (orthonormalEmbedding w hw) X) p)
          ((adjoint (orthonormalEmbedding w hw)) v)) :=
  sirk_band_refinement_poly (orthonormalEmbedding w hw) (orthonormalEmbedding w' hw')
    (coordIncl hmn) X (orthonormalEmbedding_nested hmn w w' hw hw' hnest)
    (orthonormalEmbedding_adjoint_comp w' hw') (coordIncl_adjoint_comp hmn)
    hinvm hinvn p v hv

omit [CompleteSpace E] in
/-- The range of the embedding is the span of the family: for a Krylov basis, the
Krylov subspace itself. -/
theorem orthonormalEmbedding_range {m : ℕ} (w : Fin m → E) (hw : Orthonormal ℂ w) :
    LinearMap.range (orthonormalEmbedding w hw : EuclideanSpace ℂ (Fin m) →ₗ[ℂ] E)
      = Submodule.span ℂ (Set.range w) := by
  have hbasis : Submodule.span ℂ (Set.range ((EuclideanSpace.basisFun (Fin m) ℂ).toBasis))
      = (⊤ : Submodule ℂ (EuclideanSpace ℂ (Fin m))) :=
    (EuclideanSpace.basisFun (Fin m) ℂ).toBasis.span_eq
  have hcomp : ((orthonormalEmbedding w hw : EuclideanSpace ℂ (Fin m) →ₗ[ℂ] E) ∘
      ((EuclideanSpace.basisFun (Fin m) ℂ).toBasis)) = w := by
    funext i
    have hb : ((EuclideanSpace.basisFun (Fin m) ℂ).toBasis) i
        = EuclideanSpace.single i (1 : ℂ) := by
      simp [EuclideanSpace.basisFun_apply]
    simp only [Function.comp_apply, hb]
    exact orthonormalEmbedding_single w hw i
  rw [LinearMap.range_eq_map, ← hbasis, Submodule.map_span, ← Set.range_comp, hcomp]

omit [CompleteSpace E] in
/-- **(b) for nested orthonormal bases.**  The order-`m` reduced generator is the
leading `m × m` submatrix of the order-`n` one, stated directly for the
orthonormal families rather than for abstract embeddings. -/
theorem sirk_compression_submatrix_of_orthonormal {m n : ℕ} (hmn : m ≤ n) (X : E →L[ℂ] E)
    (w : Fin m → E) (w' : Fin n → E) (hw : Orthonormal ℂ w) (hw' : Orthonormal ℂ w')
    (hnest : ∀ i : Fin m, w i = w' (Fin.castLE hmn i)) :
    reduceGenerator m (orthonormalEmbedding w hw) X
      = (reduceGenerator n (orthonormalEmbedding w' hw') X).submatrix
          (Fin.castLE hmn) (Fin.castLE hmn) :=
  sirk_compression_submatrix_le hmn X _ _ fun i => by
    rw [orthonormalEmbedding_single, orthonormalEmbedding_single, hnest]

end Realization

/-! ## Part 2 — the nested orthonormal Krylov bases exist

Gram–Schmidt applied to the Krylov sequence `k ↦ Hᵏ v`, indexed by `ℕ`, produces a
*single* orthonormal sequence whose prefixes are orthonormal bases of the Krylov
subspaces.  Nesting is then automatic — the order-`m` basis is literally the first
`m` members of the order-`n` one — so the realization of Part 1 applies to the
Krylov flag itself. -/

section KrylovBases

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap InnerProductSpace

omit [CompleteSpace E] in
/-- Linear independence of a prefix of an `ℕ`-indexed family passes to shorter
prefixes. -/
theorem li_Fin_of_le (f : ℕ → E) {m n : ℕ} (hmn : m ≤ n)
    (hli : LinearIndependent ℂ (fun i : Fin n => f i)) :
    LinearIndependent ℂ (fun i : Fin m => f i) := by
  have h := hli.comp (Fin.castLE hmn) (Fin.castLE_injective hmn)
  simpa [Function.comp] using h

omit [CompleteSpace E] in
/-- Linear independence of a prefix also gives linear independence of every
initial segment `Set.Iic i`, in the form Gram–Schmidt asks for. -/
theorem li_Iic_of_li_Fin {f : ℕ → E} {n : ℕ} (hli : LinearIndependent ℂ (fun i : Fin n => f i))
    {i : ℕ} (hi : i < n) :
    LinearIndependent ℂ (f ∘ (Subtype.val : Set.Iic i → ℕ)) := by
  have he : Function.Injective (fun j : Set.Iic i => (⟨j.1, lt_of_le_of_lt j.2 hi⟩ : Fin n)) := by
    intro a b hab
    apply Subtype.ext
    simpa [Fin.ext_iff] using hab
  exact hli.comp _ he

omit [CompleteSpace E] in
/-- **Prefix orthonormality.**  If the first `n` members of an `ℕ`-indexed family
are linearly independent, the first `n` normalized Gram–Schmidt vectors are
orthonormal — no global linear independence is needed. -/
theorem gramSchmidtNormed_orthonormal_prefix {f : ℕ → E} {n : ℕ}
    (hli : LinearIndependent ℂ (fun i : Fin n => f i)) :
    Orthonormal ℂ (fun i : Fin n => gramSchmidtNormed ℂ f (i : ℕ)) := by
  constructor
  · intro i
    exact gramSchmidtNormed_unit_length_coe (i : ℕ) (li_Iic_of_li_Fin hli i.2)
  · intro i j hij
    have hne : (i : ℕ) ≠ (j : ℕ) := fun h => hij (Fin.ext h)
    have h := gramSchmidt_orthogonal ℂ f hne
    simp only [gramSchmidtNormed]
    rw [inner_smul_left, inner_smul_right, h]
    simp

/-- The orthonormal Krylov sequence: Gram–Schmidt applied to `k ↦ Hᵏ v`.  Its
prefixes are the nested orthonormal Krylov bases used by the SIRK method. -/
def krylovOrthonormalSeq (H : E →ₗ[ℂ] E) (v : E) : ℕ → E :=
  gramSchmidtNormed ℂ (fun k : ℕ => (H ^ k) v)

omit [CompleteSpace E] in
/-- Linear independence of the Krylov prefix passes to shorter prefixes. -/
theorem krylov_li_of_le {H : E →ₗ[ℂ] E} {v : E} {m n : ℕ} (hmn : m ≤ n)
    (hli : LinearIndependent ℂ (fun i : Fin n => (H ^ (i : ℕ)) v)) :
    LinearIndependent ℂ (fun i : Fin m => (H ^ (i : ℕ)) v) :=
  li_Fin_of_le (fun k : ℕ => (H ^ k) v) hmn hli

omit [CompleteSpace E] in
/-- **The order-`n` Krylov basis is orthonormal** as soon as the Krylov sequence
has not broken down before order `n`. -/
theorem krylovOrthonormal_orthonormal (H : E →ₗ[ℂ] E) (v : E) {n : ℕ}
    (hli : LinearIndependent ℂ (fun i : Fin n => (H ^ (i : ℕ)) v)) :
    Orthonormal ℂ (fun i : Fin n => krylovOrthonormalSeq H v (i : ℕ)) :=
  gramSchmidtNormed_orthonormal_prefix hli

omit [CompleteSpace E] in
/-- **The bases are nested by construction**: the order-`m` basis is the first `m`
members of the order-`n` one, for `m ≤ n`. -/
theorem krylovOrthonormal_nested {H : E →ₗ[ℂ] E} {v : E} {m n : ℕ} (hmn : m ≤ n)
    (i : Fin m) :
    krylovOrthonormalSeq H v (i : ℕ)
      = krylovOrthonormalSeq H v ((Fin.castLE hmn i : Fin n) : ℕ) := rfl

omit [CompleteSpace E] in
/-- **They span the Krylov subspace**: the order-`n` orthonormal Krylov family
spans `Kry n(H, v)` (`ChapterH5.krylovSpan`). -/
theorem krylovOrthonormal_span (H : E →ₗ[ℂ] E) (v : E) (n : ℕ) :
    Submodule.span ℂ (Set.range (fun i : Fin n => krylovOrthonormalSeq H v (i : ℕ)))
      = krylovSpan H v n := by
  have hrange : (Set.range (fun i : Fin n => krylovOrthonormalSeq H v (i : ℕ)))
      = krylovOrthonormalSeq H v '' Set.Iio n := by
    ext x
    constructor
    · rintro ⟨i, rfl⟩
      exact ⟨i, i.2, rfl⟩
    · rintro ⟨i, hi, rfl⟩
      exact ⟨⟨i, hi⟩, rfl⟩
  rw [hrange, krylovOrthonormalSeq, span_gramSchmidtNormed, span_gramSchmidt_Iio, krylovSpan]
  congr 1
  ext x
  constructor
  · rintro ⟨i, hi, rfl⟩
    exact ⟨i, hi, rfl⟩
  · rintro ⟨i, hi, rfl⟩
    exact ⟨i, hi, rfl⟩

/-- The order-`n` **Krylov embedding** `Vₙ : EuclideanSpace ℂ (Fin n) →L[ℂ] E`: the
isometry sending coordinate vectors to the orthonormal Krylov basis. -/
def krylovEmbedding (H : E →ₗ[ℂ] E) (v : E) {n : ℕ}
    (hli : LinearIndependent ℂ (fun i : Fin n => (H ^ (i : ℕ)) v)) :
    EuclideanSpace ℂ (Fin n) →L[ℂ] E :=
  orthonormalEmbedding (fun i : Fin n => krylovOrthonormalSeq H v (i : ℕ))
    (krylovOrthonormal_orthonormal H v hli)

omit [CompleteSpace E] in
/-- **The Krylov embedding has the Krylov subspace as its range.** -/
theorem krylovEmbedding_range (H : E →ₗ[ℂ] E) (v : E) {n : ℕ}
    (hli : LinearIndependent ℂ (fun i : Fin n => (H ^ (i : ℕ)) v)) :
    LinearMap.range (krylovEmbedding H v hli : EuclideanSpace ℂ (Fin n) →ₗ[ℂ] E)
      = krylovSpan H v n := by
  rw [krylovEmbedding, orthonormalEmbedding_range, krylovOrthonormal_span]

/-- **(c) for the Krylov flag itself.**  For orders `m ≤ n` at which the Krylov
sequence has not broken down, and a generator `X` leaving both Krylov ranges
invariant, the order-`n` SIRK approximant of `p(X) u` agrees with the order-`m`
one on the order-`m` data: the approximations really do nest, with the bases the
method builds. -/
theorem sirk_band_refinement_krylov {m n : ℕ} (hmn : m ≤ n) (H : E →ₗ[ℂ] E) (v : E)
    (X : E →L[ℂ] E) (hli : LinearIndependent ℂ (fun i : Fin n => (H ^ (i : ℕ)) v))
    (hinvm : ∀ x : EuclideanSpace ℂ (Fin m), ∃ y : EuclideanSpace ℂ (Fin m),
      X (krylovEmbedding H v (krylov_li_of_le hmn hli) x)
        = krylovEmbedding H v (krylov_li_of_le hmn hli) y)
    (hinvn : ∀ x : EuclideanSpace ℂ (Fin n), ∃ y : EuclideanSpace ℂ (Fin n),
      X (krylovEmbedding H v hli x) = krylovEmbedding H v hli y)
    (p : Polynomial ℂ) (u : E)
    (hu : krylovEmbedding H v (krylov_li_of_le hmn hli)
      ((adjoint (krylovEmbedding H v (krylov_li_of_le hmn hli))) u) = u) :
    krylovEmbedding H v hli
        ((Polynomial.aeval (compress (krylovEmbedding H v hli) X) p)
          ((adjoint (krylovEmbedding H v hli)) u))
      = krylovEmbedding H v (krylov_li_of_le hmn hli)
        ((Polynomial.aeval (compress (krylovEmbedding H v (krylov_li_of_le hmn hli)) X) p)
          ((adjoint (krylovEmbedding H v (krylov_li_of_le hmn hli))) u)) :=
  sirk_band_refinement_of_orthonormal hmn X
    (fun i : Fin m => krylovOrthonormalSeq H v (i : ℕ))
    (fun i : Fin n => krylovOrthonormalSeq H v (i : ℕ))
    (krylovOrthonormal_orthonormal H v (krylov_li_of_le hmn hli))
    (krylovOrthonormal_orthonormal H v hli)
    (fun _ => rfl) hinvm hinvn p u hu

end KrylovBases

end BookProof.ChapterH8

end
