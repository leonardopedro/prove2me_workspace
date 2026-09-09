import Mathlib
import BookProof.ChapterH4
import BookProof.ChapterH5
import BookProof.ChapterH6

/-!
# Chapter H8 — the SIRK approximation orders nest (plan `PLAN_LEAN_SPECIALIST_SIRK_NESTED.md`)

The Hashimoto SIRK approximations form a *nested tower of orders*: the order-`n+1`
approximation refines the order-`n` one.  This file proves the four ingredients of
that statement for the generic Krylov–Hashimoto machinery of `ChapterH4`–`ChapterH6`
(it is not Navier–Stokes specific — it constrains any SIRK evolution).

## Deliverables

* **(a) subspace nesting** — `sirk_krylov_tower`: `Kry n ≤ Kry (n+1)`, the tower
  form of `ChapterH5.krylovSpan_mono`;
* **(b) block compatibility (new)** — `sirk_compression_block` /
  `sirk_compression_submatrix`: for nested orthonormal bases
  (`Vₙ eᵢ = Vₙ₊₁ e_{castSucc i}`) the order-`n` reduced generator
  (`ChapterH6.reduceGenerator`) is the leading `n × n` block of the order-`n+1`
  one; between any two orders `m ≤ n` this is `sirk_compression_block_le` /
  `sirk_compression_submatrix_le`.  Its operator form is `sirk_compression_block_op`,
  `compress Vₙ X = J∗ (compress Vₙ₊₁ X) J` for the coordinate inclusion `J`
  with `Vₙ = Vₙ₊₁ ∘ J`;
* **(c) projection refinement (new, headline)** — `sirk_band_refinement`: on the
  order-`n` data (`v ∈ Kry n`, i.e. `Vₙ Vₙ∗ v = v`) the order-`n+1` approximant
  *equals* the order-`n` approximant, and `sirk_band_refinement_proj` states this
  as "project the finer approximant back into `Kry n`".  On the *whole* space the
  statement `sirk_approx_projection` needs `Kry n` to reduce `X` (invariant under
  both `X` and `X∗`); the intertwining engine is
  `compress_comp_intertwine` / `compress_pow_comp_intertwine`;
* **(c′) polynomial and rational refinement (new)** — the same refinement for the
  functions the SIRK method actually evaluates: `sirk_band_refinement_poly` for
  an arbitrary polynomial `p` of the reduced generator,
  `sirk_band_refinement_rational` for a rational function `p/q` (an invertible
  denominator and its invertible compression), and `sirk_approx_projection_poly`
  for the whole-space projection form, and `sirk_approx_projection_rational` for
  the whole-space form of the rational case (the subspace must reduce both the
  numerator generator and the denominator).  The transfer engines are
  `compress_aeval_comp`, `compress_aeval_transfer`, `compress_inv_transfer_apply`,
  `compress_rational_transfer`, the transposed intertwinings
  `compress_adjoint_intertwine` / `compress_adjoint_intertwine_poly` and the
  inverse-intertwining lemma `inv_comp_intertwine`;
* **(c″) the hypotheses are realized** — the refinement theorems here are stated
  for an abstract factorization `Vₘ = Vₙ ∘ J`; the companion module
  `BookProof/ChapterH8Bases.lean` shows the hypotheses are met by any nested pair
  of orthonormal families, and by the orthonormal Krylov bases themselves
  (`sirk_band_refinement_of_orthonormal`, `sirk_band_refinement_krylov`);
* **(d) band containment** — `sirk_band_contained`: the error bands nest,
  `[0, sirkBound (n+1)] ⊆ [0, sirkBound n]` (from
  `ChapterH6.sirk_error_bound_antitone`), and `sirk_bands_tendsto_zero` records
  that the nested family collapses to `{0}`
  (`ChapterH6.sirk_error_decay_exponential`);
* **the tower** — `sirk_nested_orders` assembles (a) and (d) for every `n`, and
  `sirk_nested_orders_le` / `sirk_band_contained_le` do so between any two orders
  `m ≤ n`.

## Correspondence

`ChapterH5.lean` supplies the Krylov span and its monotonicity, `ChapterH6.lean`
the reduced generator and the antitone/decaying bound, `ChapterH4.lean` the
compression `compress = V∗ X V` and its transfer identities
(`compress_pow`, `compress_transfer`, `compress_inv_transfer`).  The prose
counterpart is the nested-orders paragraph of `Book/FreeField.lean`
§"Dimensional Reduction".

## The exact boundary

Everything here is finite-dimensional linear algebra over the decidable skeleton:
no Crouzeix inequality, no infinite spectrum, no `EXTERNAL` hypothesis.  What is
**not** claimed is the numerical *width* of the bands — that the true error lies
inside `sirkBound n` is conditional on Crouzeix's inequality, which enters
`ChapterH4.sirk_error_bound_decay` as a *named hypothesis*, never an axiom.  The
nesting (a)–(d) holds whether or not Crouzeix is ever proved.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterH8

open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

/-! ## Part 1 — the Krylov subspaces nest -/

section Tower

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

/-- **(a)** The Krylov flag is a tower: the order-`n` subspace sits inside the
order-`n+1` subspace.  Tower form of `ChapterH5.krylovSpan_mono`. -/
theorem sirk_krylov_tower (H : E →ₗ[K] E) (v : E) (n : ℕ) :
    krylovSpan H v n ≤ krylovSpan H v (n + 1) :=
  krylovSpan_mono (Nat.le_succ n)

end Tower

/-! ## Part 2 — the block compatibility lemma -/

section Compression

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

open ContinuousLinearMap in
/-- **(b), operator form.**  If the coarse embedding factors through the fine one,
`Vₙ = Vₙ₊₁ ∘ J`, then the coarse compression is the `J`-block of the fine
compression: `V∗ₙ X Vₙ = J∗ (V∗ₙ₊₁ X Vₙ₊₁) J`. -/
theorem sirk_compression_block_op (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J) :
    compress Vn X = (adjoint J).comp ((compress Vm X).comp J) := by
  subst hJ
  ext x
  simp [compress]

open ContinuousLinearMap in
/-- The coarse embedding is isometric as soon as the fine one is and the
coordinate inclusion `J` is: `V∗ₙ Vₙ = 1`. -/
theorem adjoint_comp_self_of_nested (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F) :
    (adjoint Vn).comp Vn = ContinuousLinearMap.id ℂ F := by
  subst hJ
  ext x
  have hx : (adjoint Vm) (Vm (J x)) = J x :=
    congrArg (fun f : G →L[ℂ] G => f (J x)) hVm
  have hy : (adjoint J) (J x) = x :=
    congrArg (fun f : F →L[ℂ] F => f x) hJJ
  simp [hx, hy]

open ContinuousLinearMap in
/-- The coarse adjoint composed with the fine embedding is the coordinate
projection: `V∗ₙ Vₙ₊₁ = J∗`. -/
theorem adjoint_comp_nested (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G) :
    (adjoint Vn).comp Vm = adjoint J := by
  subst hJ
  ext x
  have hx : (adjoint Vm) (Vm x) = x :=
    congrArg (fun f : G →L[ℂ] G => f x) hVm
  simp [hx]

open ContinuousLinearMap in
/-- The adjoint of a compression is the compression of the adjoint. -/
theorem adjoint_compress (V : F →L[ℂ] E) (X : E →L[ℂ] E) :
    adjoint (compress V X) = compress V (adjoint X) := by
  rw [compress, compress, adjoint_comp, adjoint_comp, adjoint_adjoint,
    ContinuousLinearMap.comp_assoc]

open ContinuousLinearMap in
/-- The adjoint of a power is the power of the adjoint. -/
theorem adjoint_pow (A : F →L[ℂ] F) (k : ℕ) : adjoint (A ^ k) = (adjoint A) ^ k := by
  simp [← ContinuousLinearMap.star_eq_adjoint, star_pow]

end Compression

/-! ### The matrix form of the block lemma -/

section Block

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

omit [CompleteSpace E] in
/-- **(b), matrix entry form.**  For nested orthonormal Krylov bases
(`Vₙ eᵢ = Vₙ₊₁ e_{castSucc i}`) the order-`n` reduced generator entry `(i, j)` is
the entry `(castSucc i, castSucc j)` of the order-`n+1` reduced generator: the
order-`n` reduced matrix is the leading `n × n` submatrix of the order-`n+1`
one. -/
theorem sirk_compression_block (n : ℕ) (X : E →L[ℂ] E)
    (Vn : EuclideanSpace ℂ (Fin n) →L[ℂ] E)
    (Vm : EuclideanSpace ℂ (Fin (n + 1)) →L[ℂ] E)
    (hnest : ∀ i : Fin n, Vn (EuclideanSpace.single i (1 : ℂ))
      = Vm (EuclideanSpace.single (Fin.castSucc i) (1 : ℂ)))
    (i j : Fin n) :
    reduceGenerator n Vn X i j
      = reduceGenerator (n + 1) Vm X (Fin.castSucc i) (Fin.castSucc j) := by
  simp [reduceGenerator, hnest]

omit [CompleteSpace E] in
/-- **(b), submatrix form.**  `Bₙ` is the leading `n × n` submatrix of `Bₙ₊₁`. -/
theorem sirk_compression_submatrix (n : ℕ) (X : E →L[ℂ] E)
    (Vn : EuclideanSpace ℂ (Fin n) →L[ℂ] E)
    (Vm : EuclideanSpace ℂ (Fin (n + 1)) →L[ℂ] E)
    (hnest : ∀ i : Fin n, Vn (EuclideanSpace.single i (1 : ℂ))
      = Vm (EuclideanSpace.single (Fin.castSucc i) (1 : ℂ))) :
    reduceGenerator n Vn X
      = (reduceGenerator (n + 1) Vm X).submatrix Fin.castSucc Fin.castSucc := by
  ext i j
  simpa using sirk_compression_block n X Vn Vm hnest i j

omit [CompleteSpace E] in
/-- **(b) at arbitrary orders.**  For any pair of orders `m ≤ n` with nested bases
(`Vₘ eᵢ = Vₙ e_{castLE i}`) the order-`m` reduced generator is the leading
`m × m` submatrix of the order-`n` one — the block identity iterated up the whole
tower, not just one step. -/
theorem sirk_compression_block_le {m n : ℕ} (hmn : m ≤ n) (X : E →L[ℂ] E)
    (Vm : EuclideanSpace ℂ (Fin m) →L[ℂ] E)
    (Vn : EuclideanSpace ℂ (Fin n) →L[ℂ] E)
    (hnest : ∀ i : Fin m, Vm (EuclideanSpace.single i (1 : ℂ))
      = Vn (EuclideanSpace.single (Fin.castLE hmn i) (1 : ℂ)))
    (i j : Fin m) :
    reduceGenerator m Vm X i j
      = reduceGenerator n Vn X (Fin.castLE hmn i) (Fin.castLE hmn j) := by
  simp [reduceGenerator, hnest]

omit [CompleteSpace E] in
/-- **(b) at arbitrary orders, submatrix form.** -/
theorem sirk_compression_submatrix_le {m n : ℕ} (hmn : m ≤ n) (X : E →L[ℂ] E)
    (Vm : EuclideanSpace ℂ (Fin m) →L[ℂ] E)
    (Vn : EuclideanSpace ℂ (Fin n) →L[ℂ] E)
    (hnest : ∀ i : Fin m, Vm (EuclideanSpace.single i (1 : ℂ))
      = Vn (EuclideanSpace.single (Fin.castLE hmn i) (1 : ℂ))) :
    reduceGenerator m Vm X
      = (reduceGenerator n Vn X).submatrix (Fin.castLE hmn) (Fin.castLE hmn) := by
  ext i j
  simpa using sirk_compression_block_le hmn X Vm Vn hnest i j

end Block

/-! ## Part 3 — the projection-refinement theorems -/

section Refinement

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

open ContinuousLinearMap

/-- **Intertwining.**  If the coarse range `Kry n` is `X`-invariant, the coarse
compression intertwines with the fine one along the coordinate inclusion:
`Bₙ₊₁ ∘ J = J ∘ Bₙ`.  (This is the block-triangularity that makes the leading
block of the fine reduced generator a *generator in its own right*.) -/
theorem compress_comp_intertwine (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvn : ∀ x : F, ∃ y : F, X (Vn x) = Vn y) :
    (compress Vm X).comp J = J.comp (compress Vn X) := by
  have hVn : (adjoint Vn).comp Vn = ContinuousLinearMap.id ℂ F :=
    adjoint_comp_self_of_nested Vn Vm J hJ hVm hJJ
  ext x
  obtain ⟨y, hy⟩ := hinvn x
  have hVmJ : Vm (J x) = Vn x := by rw [hJ]; rfl
  have hVmJy : Vm (J y) = Vn y := by rw [hJ]; rfl
  have hleft : (adjoint Vm) (Vm (J y)) = J y :=
    congrArg (fun f : G →L[ℂ] G => f (J y)) hVm
  have hright : (adjoint Vn) (Vn y) = y :=
    congrArg (fun f : F →L[ℂ] F => f y) hVn
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply, compress]
  rw [hVmJ, hy, hright, ← hVmJy, hleft]

/-- Powers of the intertwining relation: `Bₙ₊₁^k ∘ J = J ∘ Bₙ^k`. -/
theorem compress_pow_comp_intertwine (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvn : ∀ x : F, ∃ y : F, X (Vn x) = Vn y) (k : ℕ) :
    ((compress Vm X) ^ k).comp J = J.comp ((compress Vn X) ^ k) := by
  have hstep := compress_comp_intertwine Vn Vm J X hJ hVm hJJ hinvn
  induction k with
  | zero => ext x; simp
  | succ k ih =>
    ext x
    have h1 : ((compress Vm X) ^ (k + 1)) (J x)
        = ((compress Vm X) ^ k) ((compress Vm X) (J x)) := by
      rw [pow_succ]
      rfl
    have h2 : J (((compress Vn X) ^ (k + 1)) x)
        = J (((compress Vn X) ^ k) ((compress Vn X) x)) := by
      rw [pow_succ]
      rfl
    have hs : (compress Vm X) (J x) = J ((compress Vn X) x) :=
      congrArg (fun f : F →L[ℂ] G => f x) hstep
    have hi := congrArg (fun f : F →L[ℂ] G => f ((compress Vn X) x)) ih
    simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at hi ⊢
    rw [h1, h2, hs, hi]

/-- Membership in the coarse range is inherited by the fine range. -/
theorem fine_range_of_coarse (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (v : E) (hv : Vn ((adjoint Vn) v) = v) :
    Vm ((adjoint Vm) v) = v := by
  set w : F := (adjoint Vn) v with hw
  have hvw : v = Vm (J w) := by rw [hJ] at hv; exact hv.symm
  have hmm : (adjoint Vm) (Vm (J w)) = J w :=
    congrArg (fun f : G →L[ℂ] G => f (J w)) hVm
  rw [hvw, hmm]

/-- **(c) Headline — the finer band restricted to the coarser data is the coarser
band.**  For `v` in the order-`n` Krylov subspace (`Vₙ Vₙ∗ v = v`) the order-`n+1`
SIRK approximant of `Xᵏ v` and the order-`n` one *coincide*: both equal `Xᵏ v` by
the transfer identity `ChapterH4.compress_transfer`. -/
theorem sirk_band_refinement (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvn : ∀ x : F, ∃ y : F, X (Vn x) = Vn y)
    (hinvm : ∀ x : G, ∃ y : G, X (Vm x) = Vm y)
    (k : ℕ) (v : E) (hv : Vn ((adjoint Vn) v) = v) :
    Vm (((compress Vm X) ^ k) ((adjoint Vm) v)) = Vn (((compress Vn X) ^ k) ((adjoint Vn) v)) := by
  have hVn : (adjoint Vn).comp Vn = ContinuousLinearMap.id ℂ F :=
    adjoint_comp_self_of_nested Vn Vm J hJ hVm hJJ
  have hvm : Vm ((adjoint Vm) v) = v := fine_range_of_coarse Vn Vm J hJ hVm v hv
  have hn := compress_transfer Vn X hVn hinvn k v hv
  have hm := compress_transfer Vm X hVm hinvm k v hvm
  rw [← hm, ← hn]

/-- **(c) as a projection statement.**  On the order-`n` data, projecting the
order-`n+1` approximant back into `Kry n` (the projection is `Vₙ Vₙ∗`) returns the
order-`n` approximant. -/
theorem sirk_band_refinement_proj (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvn : ∀ x : F, ∃ y : F, X (Vn x) = Vn y)
    (hinvm : ∀ x : G, ∃ y : G, X (Vm x) = Vm y)
    (k : ℕ) (v : E) (hv : Vn ((adjoint Vn) v) = v) :
    Vn ((adjoint Vn) (Vm (((compress Vm X) ^ k) ((adjoint Vm) v))))
      = Vn (((compress Vn X) ^ k) ((adjoint Vn) v)) := by
  have hVn : (adjoint Vn).comp Vn = ContinuousLinearMap.id ℂ F :=
    adjoint_comp_self_of_nested Vn Vm J hJ hVm hJJ
  have href := sirk_band_refinement Vn Vm J X hJ hVm hJJ hinvn hinvm k v hv
  rw [href]
  have := congrArg (fun f : F →L[ℂ] F => f (((compress Vn X) ^ k) ((adjoint Vn) v))) hVn
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply,
    ContinuousLinearMap.coe_id', id_eq] at this
  rw [this]

/-- **(c) on the whole space.**  If the order-`n` Krylov subspace *reduces* `X`
(its range is invariant under both `X` and `X∗`), then for **every** `v` the
order-`n` approximant is exactly the order-`n+1` approximant projected back into
`Kry n`.  The `X∗`-invariance is genuinely needed: without it the leading block
governs only the coarse data (`sirk_band_refinement`), not arbitrary vectors. -/
theorem sirk_approx_projection (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvadj : ∀ x : F, ∃ y : F, (adjoint X) (Vn x) = Vn y)
    (k : ℕ) (v : E) :
    Vn ((adjoint Vn) (Vm (((compress Vm X) ^ k) ((adjoint Vm) v))))
      = Vn (((compress Vn X) ^ k) ((adjoint Vn) v)) := by
  -- the `X∗`-intertwining, transposed to `J∗ ∘ Bₙ₊₁ᵏ = Bₙᵏ ∘ J∗`
  have hstar := compress_pow_comp_intertwine Vn Vm J (adjoint X) hJ hVm hJJ hinvadj k
  have hadj := congrArg ContinuousLinearMap.adjoint hstar
  rw [adjoint_comp, adjoint_comp, adjoint_pow, adjoint_pow, adjoint_compress, adjoint_compress,
    adjoint_adjoint] at hadj
  -- `V∗ₙ Vₙ₊₁ = J∗`
  have hproj : (adjoint Vn).comp Vm = adjoint J := adjoint_comp_nested Vn Vm J hJ hVm
  have h1 : (adjoint Vn) (Vm (((compress Vm X) ^ k) ((adjoint Vm) v)))
      = (adjoint J) (((compress Vm X) ^ k) ((adjoint Vm) v)) :=
    congrArg (fun f : G →L[ℂ] F => f (((compress Vm X) ^ k) ((adjoint Vm) v))) hproj
  have h2 : (adjoint J) (((compress Vm X) ^ k) ((adjoint Vm) v))
      = ((compress Vn X) ^ k) ((adjoint J) ((adjoint Vm) v)) :=
    congrArg (fun f : G →L[ℂ] F => f ((adjoint Vm) v)) hadj
  have h3 : (adjoint J) ((adjoint Vm) v) = (adjoint Vn) v := by
    have : (adjoint Vn) = (adjoint J).comp (adjoint Vm) := by
      rw [hJ, adjoint_comp]
    rw [this]
    rfl
  rw [h1, h2, h3]

end Refinement

/-! ## Part 3b — refinement for polynomial and rational functions -/

section RationalRefinement

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

open ContinuousLinearMap

/-- **Polynomial transfer.**  If the range of the isometry `V` is `X`-invariant,
every polynomial in `X` transfers to the same polynomial in the compression:
`p(X) ∘ V = V ∘ p(B)`.  Linear extension of `ChapterH4.compress_pow`. -/
theorem compress_aeval_comp (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hVV : (adjoint V).comp V = ContinuousLinearMap.id ℂ F)
    (hinv : ∀ x : F, ∃ y : F, X (V x) = V y) (p : Polynomial ℂ) :
    (Polynomial.aeval X p).comp V = V.comp (Polynomial.aeval (compress V X) p) := by
  induction p using Polynomial.induction_on' with
  | add p q hp hq =>
      simp [map_add, ContinuousLinearMap.add_comp, ContinuousLinearMap.comp_add, hp, hq]
  | monomial k c =>
      have h := compress_pow V X hVV hinv k
      ext x
      have hx := congrArg (fun f : F →L[ℂ] E => f x) h
      simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at hx
      simp only [Polynomial.aeval_monomial, ContinuousLinearMap.coe_comp', Function.comp_apply,
        ContinuousLinearMap.mul_apply]
      rw [hx]
      simp [Algebra.algebraMap_eq_smul_one]

/-- **Pointwise polynomial transfer.**  On the range of `V`, `p(X) v = V p(B) V∗ v`. -/
theorem compress_aeval_transfer (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hVV : (adjoint V).comp V = ContinuousLinearMap.id ℂ F)
    (hinv : ∀ x : F, ∃ y : F, X (V x) = V y) (p : Polynomial ℂ)
    (v : E) (hv : V ((adjoint V) v) = v) :
    (Polynomial.aeval X p) v = V ((Polynomial.aeval (compress V X) p) ((adjoint V) v)) := by
  have h := congrArg (fun f : F →L[ℂ] E => f ((adjoint V) v))
    (compress_aeval_comp V X hVV hinv p)
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at h
  rw [hv] at h
  exact h

/-- **Pointwise resolvent transfer.**  On the range of `V`, an invertible
denominator transfers to the inverse of its compression:
`qX⁻¹ v = V qB⁻¹ V∗ v`.  Pointwise form of `ChapterH4.compress_inv_transfer`. -/
theorem compress_inv_transfer_apply (V : F →L[ℂ] E) (qX qXinv : E →L[ℂ] E) (qBinv : F →L[ℂ] F)
    (hVV : (adjoint V).comp V = ContinuousLinearMap.id ℂ F)
    (hinv : ∀ x : F, ∃ y : F, qX (V x) = V y)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ E)
    (hqBr : (compress V qX).comp qBinv = ContinuousLinearMap.id ℂ F)
    (v : E) (hv : V ((adjoint V) v) = v) :
    qXinv v = V (qBinv ((adjoint V) v)) := by
  have h := compress_inv_transfer V qX qXinv (compress V qX) qBinv
    (compress_X_comp_V V qX hVV hinv) hqXl hqBr
  have h2 := congrArg (fun f : F →L[ℂ] E => f ((adjoint V) v)) h
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at h2
  rw [hv] at h2
  exact h2

/-- **Rational transfer.**  For a rational function `r = p / q` (numerator the
polynomial `p`, denominator the invertible `qX` with invertible compression), the
value `r(X) v` on the range of `V` is computed by the reduced operator:
`p(X) qX⁻¹ v = V p(B) qB⁻¹ V∗ v`. -/
theorem compress_rational_transfer (V : F →L[ℂ] E) (X qX qXinv : E →L[ℂ] E)
    (qBinv : F →L[ℂ] F) (p : Polynomial ℂ)
    (hVV : (adjoint V).comp V = ContinuousLinearMap.id ℂ F)
    (hinvX : ∀ x : F, ∃ y : F, X (V x) = V y)
    (hinvq : ∀ x : F, ∃ y : F, qX (V x) = V y)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ E)
    (hqBr : (compress V qX).comp qBinv = ContinuousLinearMap.id ℂ F)
    (v : E) (hv : V ((adjoint V) v) = v) :
    (Polynomial.aeval X p) (qXinv v)
      = V ((Polynomial.aeval (compress V X) p) (qBinv ((adjoint V) v))) := by
  have hw : qXinv v = V (qBinv ((adjoint V) v)) :=
    compress_inv_transfer_apply V qX qXinv qBinv hVV hinvq hqXl hqBr v hv
  have hid : ∀ u : F, (adjoint V) (V u) = u :=
    fun u => congrArg (fun f : F →L[ℂ] F => f u) hVV
  have hVu : V ((adjoint V) (V (qBinv ((adjoint V) v)))) = V (qBinv ((adjoint V) v)) := by
    rw [hid]
  rw [hw, compress_aeval_transfer V X hVV hinvX p _ hVu, hid]

/-- **(c) for polynomials.**  On the order-`n` data the order-`n+1` approximant of
`p(X) v` equals the order-`n` one, for *every* polynomial `p` — the power case is
`sirk_band_refinement`. -/
theorem sirk_band_refinement_poly (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvn : ∀ x : F, ∃ y : F, X (Vn x) = Vn y)
    (hinvm : ∀ x : G, ∃ y : G, X (Vm x) = Vm y)
    (p : Polynomial ℂ) (v : E) (hv : Vn ((adjoint Vn) v) = v) :
    Vm ((Polynomial.aeval (compress Vm X) p) ((adjoint Vm) v))
      = Vn ((Polynomial.aeval (compress Vn X) p) ((adjoint Vn) v)) := by
  have hVn : (adjoint Vn).comp Vn = ContinuousLinearMap.id ℂ F :=
    adjoint_comp_self_of_nested Vn Vm J hJ hVm hJJ
  have hvm : Vm ((adjoint Vm) v) = v := fine_range_of_coarse Vn Vm J hJ hVm v hv
  rw [← compress_aeval_transfer Vm X hVm hinvm p v hvm,
    ← compress_aeval_transfer Vn X hVn hinvn p v hv]

/-- **(c) for rational functions.**  The SIRK approximants are rational functions
`ψ(HₘKₘ⁻¹)` of the reduced generator; on the order-`n` data the order-`n+1`
rational approximant equals the order-`n` one.  Both sides compute the exact
value `p(X) qX⁻¹ v`. -/
theorem sirk_band_refinement_rational (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X qX qXinv : E →L[ℂ] E) (qBninv : F →L[ℂ] F) (qBminv : G →L[ℂ] G)
    (p : Polynomial ℂ) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvn : ∀ x : F, ∃ y : F, X (Vn x) = Vn y)
    (hinvm : ∀ x : G, ∃ y : G, X (Vm x) = Vm y)
    (hqn : ∀ x : F, ∃ y : F, qX (Vn x) = Vn y)
    (hqm : ∀ x : G, ∃ y : G, qX (Vm x) = Vm y)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ E)
    (hqBrn : (compress Vn qX).comp qBninv = ContinuousLinearMap.id ℂ F)
    (hqBrm : (compress Vm qX).comp qBminv = ContinuousLinearMap.id ℂ G)
    (v : E) (hv : Vn ((adjoint Vn) v) = v) :
    Vm ((Polynomial.aeval (compress Vm X) p) (qBminv ((adjoint Vm) v)))
      = Vn ((Polynomial.aeval (compress Vn X) p) (qBninv ((adjoint Vn) v))) := by
  have hVn : (adjoint Vn).comp Vn = ContinuousLinearMap.id ℂ F :=
    adjoint_comp_self_of_nested Vn Vm J hJ hVm hJJ
  have hvm : Vm ((adjoint Vm) v) = v := fine_range_of_coarse Vn Vm J hJ hVm v hv
  rw [← compress_rational_transfer Vm X qX qXinv qBminv p hVm hinvm hqm hqXl hqBrm v hvm,
    ← compress_rational_transfer Vn X qX qXinv qBninv p hVn hinvn hqn hqXl hqBrn v hv]

/-- Polynomial form of the intertwining `Bₙ₊₁ ∘ J = J ∘ Bₙ`: `p(Bₙ₊₁) ∘ J = J ∘ p(Bₙ)`. -/
theorem compress_aeval_comp_intertwine (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvn : ∀ x : F, ∃ y : F, X (Vn x) = Vn y) (p : Polynomial ℂ) :
    (Polynomial.aeval (compress Vm X) p).comp J
      = J.comp (Polynomial.aeval (compress Vn X) p) := by
  induction p using Polynomial.induction_on' with
  | add p q hp hq =>
      simp [map_add, ContinuousLinearMap.add_comp, ContinuousLinearMap.comp_add, hp, hq]
  | monomial k c =>
      have h := compress_pow_comp_intertwine Vn Vm J X hJ hVm hJJ hinvn k
      ext x
      have hx := congrArg (fun f : F →L[ℂ] G => f x) h
      simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at hx
      simp only [Polynomial.aeval_monomial, ContinuousLinearMap.coe_comp', Function.comp_apply,
        ContinuousLinearMap.mul_apply]
      rw [hx]
      simp [Algebra.algebraMap_eq_smul_one]

/-- The adjoint of a polynomial in `A` is the conjugate polynomial in `A∗`. -/
theorem adjoint_aeval (A : F →L[ℂ] F) (p : Polynomial ℂ) :
    adjoint (Polynomial.aeval A p) = Polynomial.aeval (adjoint A) (p.map (starRingEnd ℂ)) := by
  induction p using Polynomial.induction_on' with
  | add p q hp hq => simp [Polynomial.map_add, hp, hq]
  | monomial k c =>
      simp [Polynomial.aeval_monomial, Algebra.algebraMap_eq_smul_one, ← star_eq_adjoint,
        star_pow, Polynomial.map_monomial]

/-- **Transposed intertwining.**  If the coarse range is `X∗`-invariant then the
coordinate projection `J∗` intertwines the two compressions the other way:
`J∗ ∘ Bₙ₊₁ = Bₙ ∘ J∗`. -/
theorem compress_adjoint_intertwine (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvadj : ∀ x : F, ∃ y : F, (adjoint X) (Vn x) = Vn y) :
    (adjoint J).comp (compress Vm X) = (compress Vn X).comp (adjoint J) := by
  have h := compress_comp_intertwine Vn Vm J (adjoint X) hJ hVm hJJ hinvadj
  have h2 := congrArg ContinuousLinearMap.adjoint h
  rw [adjoint_comp, adjoint_comp, adjoint_compress, adjoint_compress, adjoint_adjoint] at h2
  exact h2

/-- Polynomial form of the transposed intertwining: `J∗ ∘ p(Bₙ₊₁) = p(Bₙ) ∘ J∗`. -/
theorem compress_adjoint_intertwine_poly (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvadj : ∀ x : F, ∃ y : F, (adjoint X) (Vn x) = Vn y) (p : Polynomial ℂ) :
    (adjoint J).comp (Polynomial.aeval (compress Vm X) p)
      = (Polynomial.aeval (compress Vn X) p).comp (adjoint J) := by
  have hpp : (p.map (starRingEnd ℂ)).map (starRingEnd ℂ) = p := by
    simp [Polynomial.map_map]
  have hstar := compress_aeval_comp_intertwine Vn Vm J (adjoint X) hJ hVm hJJ hinvadj
    (p.map (starRingEnd ℂ))
  have hadj := congrArg ContinuousLinearMap.adjoint hstar
  rw [adjoint_comp, adjoint_comp, adjoint_aeval, adjoint_aeval, adjoint_compress,
    adjoint_compress, adjoint_adjoint, hpp] at hadj
  exact hadj

/-- **(c) on the whole space, for polynomials.**  If the order-`n` Krylov subspace
reduces `X` (here: its range is `X∗`-invariant), then for every `v` and every
polynomial `p` the order-`n` approximant is the order-`n+1` approximant projected
back into `Kry n`.  Polynomial generalization of `sirk_approx_projection`. -/
theorem sirk_approx_projection_poly (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvadj : ∀ x : F, ∃ y : F, (adjoint X) (Vn x) = Vn y)
    (p : Polynomial ℂ) (v : E) :
    Vn ((adjoint Vn) (Vm ((Polynomial.aeval (compress Vm X) p) ((adjoint Vm) v))))
      = Vn ((Polynomial.aeval (compress Vn X) p) ((adjoint Vn) v)) := by
  have hadj := compress_adjoint_intertwine_poly Vn Vm J X hJ hVm hJJ hinvadj p
  have hproj : (adjoint Vn).comp Vm = adjoint J := adjoint_comp_nested Vn Vm J hJ hVm
  have h1 : (adjoint Vn) (Vm ((Polynomial.aeval (compress Vm X) p) ((adjoint Vm) v)))
      = (adjoint J) ((Polynomial.aeval (compress Vm X) p) ((adjoint Vm) v)) :=
    congrArg (fun f : G →L[ℂ] F => f ((Polynomial.aeval (compress Vm X) p) ((adjoint Vm) v))) hproj
  have h2 : (adjoint J) ((Polynomial.aeval (compress Vm X) p) ((adjoint Vm) v))
      = (Polynomial.aeval (compress Vn X) p) ((adjoint J) ((adjoint Vm) v)) :=
    congrArg (fun f : G →L[ℂ] F => f ((adjoint Vm) v)) hadj
  have h3 : (adjoint J) ((adjoint Vm) v) = (adjoint Vn) v := by
    have hsplit : (adjoint Vn) = (adjoint J).comp (adjoint Vm) := by rw [hJ, adjoint_comp]
    rw [hsplit]
    rfl
  rw [h1, h2, h3]

omit [CompleteSpace F] [CompleteSpace G] in
/-- Inverses intertwine as soon as the operators do: from `P ∘ B = A ∘ P`, a left
inverse `Aᵢ` of `A` and a right inverse `Bᵢ` of `B` one gets `P ∘ Bᵢ = Aᵢ ∘ P`. -/
theorem inv_comp_intertwine {A : F →L[ℂ] F} {B : G →L[ℂ] G} {Ai : F →L[ℂ] F} {Bi : G →L[ℂ] G}
    (P : G →L[ℂ] F) (hAl : Ai.comp A = ContinuousLinearMap.id ℂ F)
    (hBr : B.comp Bi = ContinuousLinearMap.id ℂ G)
    (hPB : P.comp B = A.comp P) :
    P.comp Bi = Ai.comp P := by
  calc P.comp Bi = Ai.comp ((A.comp P).comp Bi) := by
        rw [← ContinuousLinearMap.comp_assoc, ← ContinuousLinearMap.comp_assoc, hAl]
        simp
    _ = Ai.comp ((P.comp B).comp Bi) := by rw [hPB]
    _ = Ai.comp P := by rw [ContinuousLinearMap.comp_assoc, hBr]; simp

/-- **(c) on the whole space, for rational functions.**  If the order-`n` Krylov
subspace reduces both the numerator generator `X` and the denominator `qX` (its
range is invariant under `X∗` and `qX∗`), then for *every* `v` the order-`n`
rational approximant is the order-`n+1` rational approximant projected back into
`Kry n`.  This is the whole-space companion of `sirk_band_refinement_rational`
and the rational generalization of `sirk_approx_projection_poly`. -/
theorem sirk_approx_projection_rational (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X qX : E →L[ℂ] E) (qBninv : F →L[ℂ] F) (qBminv : G →L[ℂ] G) (p : Polynomial ℂ)
    (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvadj : ∀ x : F, ∃ y : F, (adjoint X) (Vn x) = Vn y)
    (hqadj : ∀ x : F, ∃ y : F, (adjoint qX) (Vn x) = Vn y)
    (hqBnl : qBninv.comp (compress Vn qX) = ContinuousLinearMap.id ℂ F)
    (hqBmr : (compress Vm qX).comp qBminv = ContinuousLinearMap.id ℂ G)
    (v : E) :
    Vn ((adjoint Vn) (Vm ((Polynomial.aeval (compress Vm X) p) (qBminv ((adjoint Vm) v)))))
      = Vn ((Polynomial.aeval (compress Vn X) p) (qBninv ((adjoint Vn) v))) := by
  have hproj : (adjoint Vn).comp Vm = adjoint J := adjoint_comp_nested Vn Vm J hJ hVm
  have hqi : (adjoint J).comp qBminv = qBninv.comp (adjoint J) :=
    inv_comp_intertwine (adjoint J) hqBnl hqBmr
      (compress_adjoint_intertwine Vn Vm J qX hJ hVm hJJ hqadj)
  have hpi := compress_adjoint_intertwine_poly Vn Vm J X hJ hVm hJJ hinvadj p
  have h3 : (adjoint J) ((adjoint Vm) v) = (adjoint Vn) v := by
    have hsplit : (adjoint Vn) = (adjoint J).comp (adjoint Vm) := by rw [hJ, adjoint_comp]
    rw [hsplit]
    rfl
  have h1 : (adjoint Vn) (Vm ((Polynomial.aeval (compress Vm X) p) (qBminv ((adjoint Vm) v))))
      = (adjoint J) ((Polynomial.aeval (compress Vm X) p) (qBminv ((adjoint Vm) v))) :=
    congrArg (fun f : G →L[ℂ] F => f
      ((Polynomial.aeval (compress Vm X) p) (qBminv ((adjoint Vm) v)))) hproj
  have h2 : (adjoint J) ((Polynomial.aeval (compress Vm X) p) (qBminv ((adjoint Vm) v)))
      = (Polynomial.aeval (compress Vn X) p) ((adjoint J) (qBminv ((adjoint Vm) v))) :=
    congrArg (fun f : G →L[ℂ] F => f (qBminv ((adjoint Vm) v))) hpi
  have h4 : (adjoint J) (qBminv ((adjoint Vm) v)) = qBninv ((adjoint J) ((adjoint Vm) v)) :=
    congrArg (fun f : G →L[ℂ] F => f ((adjoint Vm) v)) hqi
  rw [h1, h2, h4, h3]

end RationalRefinement

/-! ## Part 4 — the error bands nest -/

/-- **(d)** The order-`n+1` uncertainty band is contained in the order-`n` band:
`[0, sirkBound (n+1)] ⊆ [0, sirkBound n]`.  Set-inclusion form of
`ChapterH6.sirk_error_bound_antitone`. -/
theorem sirk_band_contained (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 ≤ h) (n : ℕ) :
    Set.Icc (0 : ℝ) (sirkBound C Dmin h nv (n + 1))
      ⊆ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv n) :=
  Set.Icc_subset_Icc le_rfl
    (sirk_error_bound_antitone C Dmin h nv hC hD hnv hh (Nat.le_succ n))

/-- **(d) at arbitrary orders.**  The bands nest all the way up the tower: for
`m ≤ n` the order-`n` band is contained in the order-`m` band. -/
theorem sirk_band_contained_le (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 ≤ h) {m n : ℕ} (hmn : m ≤ n) :
    Set.Icc (0 : ℝ) (sirkBound C Dmin h nv n)
      ⊆ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv m) :=
  Set.Icc_subset_Icc le_rfl (sirk_error_bound_antitone C Dmin h nv hC hD hnv hh hmn)

/-- **(d)** The nested family of bands collapses to `{0}`: the right endpoints
tend to `0` as the Krylov order grows (`ChapterH6.sirk_error_decay_exponential`). -/
theorem sirk_bands_tendsto_zero (C Dmin h nv : ℝ) (hh : 0 < h) :
    Filter.Tendsto (fun n : ℕ => sirkBound C Dmin h nv n) Filter.atTop (nhds 0) :=
  sirk_error_decay_exponential C Dmin h nv hh

/-! ## Part 5 — the tower -/

/-- **Headline (the "and so on").**  At every order `n` the Krylov subspaces nest
and the uncertainty bands nest the other way: the order-`n+1` SIRK approximation
refines the order-`n` one, for all `n` at once. -/
theorem sirk_nested_orders {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
    (H : E →ₗ[K] E) (v : E) (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 ≤ h) :
    ∀ n : ℕ, krylovSpan H v n ≤ krylovSpan H v (n + 1)
      ∧ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv (n + 1))
          ⊆ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv n) :=
  fun n => ⟨sirk_krylov_tower H v n, sirk_band_contained C Dmin h nv hC hD hnv hh n⟩

/-- **The tower at arbitrary orders.**  For every pair of orders `m ≤ n` the
coarse Krylov subspace sits inside the fine one and the fine uncertainty band
sits inside the coarse one — the nesting iterated, not just one step.  (The
projection-refinement theorems of Part 3/3b are already stated for an arbitrary
pair of nested embeddings, so they apply verbatim to any such pair.) -/
theorem sirk_nested_orders_le {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
    (H : E →ₗ[K] E) (v : E) (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 ≤ h) {m n : ℕ} (hmn : m ≤ n) :
    krylovSpan H v m ≤ krylovSpan H v n
      ∧ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv n)
          ⊆ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv m) :=
  ⟨krylovSpan_mono hmn, sirk_band_contained_le C Dmin h nv hC hD hnv hh hmn⟩

end BookProof.ChapterH8

end
