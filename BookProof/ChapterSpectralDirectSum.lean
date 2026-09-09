import Mathlib
import BookProof.ChapterCyclicDirectSum

/-!
# The spectral multiplication model without a cyclic vector (plan GAP-2, the assembly)

`ChapterSpectralMultiplication` identifies a normal operator **with a cyclic unit
vector** with multiplication by `z` on `L²(μ)`.  `ChapterCyclicDecomposition` and
`ChapterCyclicDirectSum` split an arbitrary complex Hilbert space into an orthogonal
direct sum of subspaces cyclic for the operator.  This module performs the
**assembly**: the model of a single cyclic summand is built inside the ambient space
(so that no functional calculus of a restricted operator is needed), and the
summand models are then glued over the decomposition.

* `cyclicSubspace_eq_closure_range`, `cfcVecTo`, `denseRange_cfcVecTo` — the
  generating map `f ↦ f(T)ξ` has dense range *in the cyclic subspace of `ξ`*;
* `cyclicUnitary` — since `‖f(T)ξ‖ = ‖f‖_{L²(μ_ξ)}` (`norm_cfcHom_apply`, proved
  with no cyclicity hypothesis), that map extends to a unitary
  `L²(μ_ξ) ≃ₗᵢ[ℂ] cyclicSubspace ξ`;
* `cyclicEmbedding`, `range_cyclicEmbedding`, `cyclicEmbedding_intertwines_cfc`,
  `cyclicEmbedding_intertwines` — read in `H` it is an isometric embedding with range
  the cyclic subspace, carrying multiplication by a continuous symbol `g` into
  `g(T)`, in particular multiplication by `z` into `T`;
* HEADLINE `spectral_multiplication_model_general` — for **every** normal operator on
  a complex Hilbert space there are Borel probability measures `μₓ` on its spectrum
  and isometric embeddings `Vₓ : L²(μₓ) → H` exhibiting `H` as the Hilbert sum of the
  `L²(μₓ)`, with `T` acting on each summand as multiplication by the coordinate
  function.  No cyclic vector and no separability are assumed;
* `countable_orthogonalCyclicFamily` and
  `spectral_multiplication_model_separable` — on a *separable* space the family is
  countable (its members are unit vectors at pairwise distance `√2`), so the model is
  a countable direct sum.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open MeasureTheory Complex

namespace BookProof.ChapterSpectralDirectSum

open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterCyclicDecomposition BookProof.ChapterCyclicDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)

/-! ## 1. The generating map has dense range in the cyclic subspace -/

/-- The cyclic subspace of `ξ` is the closure of the range of `f ↦ f(T)ξ` (that range
is already a linear subspace). -/
theorem cyclicSubspace_eq_closure_range :
    (cyclicSubspace T hT xi : Set H) = closure (Set.range (cfcVec T hT xi)) := by
  have hrange : (Set.range fun g : C(spectrum ℂ T, ℂ) => cfcHom hT g xi)
      = Set.range (cfcVec T hT xi) := rfl
  have hspan : Submodule.span ℂ (Set.range fun g : C(spectrum ℂ T, ℂ) => cfcHom hT g xi)
      = LinearMap.range (cfcVec T hT xi) := by
    rw [hrange, ← LinearMap.coe_range, Submodule.span_eq]
  rw [cyclicSubspace, hspan]
  exact Submodule.topologicalClosure_coe _

/-- The generating map `f ↦ f(T)ξ`, seen as a map into the cyclic subspace of `ξ`. -/
def cfcVecTo : C(spectrum ℂ T, ℂ) →ₗ[ℂ] cyclicSubspace T hT xi :=
  LinearMap.codRestrict _ (cfcVec T hT xi) (cfcHom_apply_mem_cyclicSubspace T hT xi)

@[simp] theorem cfcVecTo_apply (f : C(spectrum ℂ T, ℂ)) :
    (cfcVecTo T hT xi f : H) = cfcHom hT f xi := rfl

theorem denseRange_cfcVecTo : DenseRange (cfcVecTo T hT xi) := by
  change Dense (Set.range (cfcVecTo T hT xi))
  rw [Topology.IsInducing.subtypeVal.dense_iff]
  intro m
  have hm : (m : H) ∈ closure (Set.range (cfcVec T hT xi)) := by
    rw [← cyclicSubspace_eq_closure_range]
    exact m.2
  refine closure_mono ?_ hm
  rintro _ ⟨f, rfl⟩
  exact ⟨cfcVecTo T hT xi f, ⟨f, rfl⟩, rfl⟩

/-! ## 2. The unitary model of one cyclic summand -/

/-- **The model of a cyclic summand.**  The map `f ↦ f(T)ξ` is an `L²(μ_ξ)`-isometry
onto a dense subspace of the cyclic subspace of `ξ`, hence extends to a unitary
`L²(μ_ξ) ≃ₗᵢ[ℂ] cyclicSubspace ξ`.  Note that no cyclicity hypothesis is needed:
`ξ` is cyclic *for its own cyclic subspace* by construction. -/
def cyclicUnitary : Lp ℂ 2 (spectralMeasure T hT xi) ≃ₗᵢ[ℂ] cyclicSubspace T hT xi :=
  (LinearEquiv.refl ℂ C(spectrum ℂ T, ℂ)).extendOfIsometry
    (ContinuousMap.toLp 2 (spectralMeasure T hT xi) ℂ).toLinearMap
    (cfcVecTo T hT xi)
    (ContinuousMap.toLp_denseRange ℂ _ (μ := spectralMeasure T hT xi) (by simp))
    (denseRange_cfcVecTo T hT xi)
    (fun f => by
      simpa using (norm_cfcHom_apply T hT xi f))

@[simp] theorem cyclicUnitary_toLp (f : C(spectrum ℂ T, ℂ)) :
    cyclicUnitary T hT xi (ContinuousMap.toLp 2 (spectralMeasure T hT xi) ℂ f)
      = cfcVecTo T hT xi f :=
  LinearEquiv.extendOfIsometry_eq _ _ _ _ _ _ f

/-- The model read inside the ambient space: an isometric embedding of `L²(μ_ξ)` into
`H` with range the cyclic subspace of `ξ`. -/
def cyclicEmbedding : Lp ℂ 2 (spectralMeasure T hT xi) →ₗᵢ[ℂ] H :=
  (cyclicSubspace T hT xi).subtypeₗᵢ.comp (cyclicUnitary T hT xi).toLinearIsometry

@[simp] theorem cyclicEmbedding_apply (u : Lp ℂ 2 (spectralMeasure T hT xi)) :
    cyclicEmbedding T hT xi u = (cyclicUnitary T hT xi u : H) := rfl

@[simp] theorem cyclicEmbedding_toLp (f : C(spectrum ℂ T, ℂ)) :
    cyclicEmbedding T hT xi (ContinuousMap.toLp 2 (spectralMeasure T hT xi) ℂ f)
      = cfcHom hT f xi := by
  simp [cyclicEmbedding]

theorem mem_cyclicSubspace_cyclicEmbedding (u : Lp ℂ 2 (spectralMeasure T hT xi)) :
    cyclicEmbedding T hT xi u ∈ cyclicSubspace T hT xi := (cyclicUnitary T hT xi u).2

/-- The range of the embedding is exactly the cyclic subspace of `ξ`. -/
theorem range_cyclicEmbedding :
    LinearMap.range (cyclicEmbedding T hT xi).toLinearMap = cyclicSubspace T hT xi := by
  apply le_antisymm
  · rintro _ ⟨u, rfl⟩
    exact mem_cyclicSubspace_cyclicEmbedding T hT xi u
  · intro v hv
    refine ⟨(cyclicUnitary T hT xi).symm ⟨v, hv⟩, ?_⟩
    change (cyclicUnitary T hT xi ((cyclicUnitary T hT xi).symm ⟨v, hv⟩) : H) = v
    rw [LinearIsometryEquiv.apply_symm_apply]

/-- **The embedding intertwines multiplication by a continuous symbol with the
functional calculus**: `V M_g = g(T) V`. -/
theorem cyclicEmbedding_intertwines_cfc (g : C(spectrum ℂ T, ℂ))
    (u : Lp ℂ 2 (spectralMeasure T hT xi)) :
    cyclicEmbedding T hT xi (mulRep (spectralMeasure T hT xi) g u)
      = cfcHom hT g (cyclicEmbedding T hT xi u) := by
  have hdense : DenseRange
      ((ContinuousMap.toLp 2 (spectralMeasure T hT xi) ℂ).toLinearMap :
        C(spectrum ℂ T, ℂ) → Lp ℂ 2 (spectralMeasure T hT xi)) :=
    ContinuousMap.toLp_denseRange ℂ _ (μ := spectralMeasure T hT xi) (by simp)
  have hcont₁ : Continuous fun v : Lp ℂ 2 (spectralMeasure T hT xi) =>
      cyclicEmbedding T hT xi (mulRep (spectralMeasure T hT xi) g v) :=
    (cyclicEmbedding T hT xi).continuous.comp
      (mulRep (spectralMeasure T hT xi) g).continuous
  have hcont₂ : Continuous fun v : Lp ℂ 2 (spectralMeasure T hT xi) =>
      cfcHom hT g (cyclicEmbedding T hT xi v) :=
    (cfcHom hT g).continuous.comp (cyclicEmbedding T hT xi).continuous
  have hfun : (fun v : Lp ℂ 2 (spectralMeasure T hT xi) =>
        cyclicEmbedding T hT xi (mulRep (spectralMeasure T hT xi) g v))
      = fun v : Lp ℂ 2 (spectralMeasure T hT xi) =>
        cfcHom hT g (cyclicEmbedding T hT xi v) := by
    refine hdense.equalizer hcont₁ hcont₂ (funext fun f => ?_)
    simp only [Function.comp_apply, ContinuousLinearMap.coe_coe]
    rw [mulRep_toLp T hT xi g f, cyclicEmbedding_toLp, cyclicEmbedding_toLp, map_mul]
    rfl
  exact congrFun hfun u

/-- **The embedding intertwines multiplication by `z` with `T`.** -/
theorem cyclicEmbedding_intertwines (u : Lp ℂ 2 (spectralMeasure T hT xi)) :
    cyclicEmbedding T hT xi (mulRep (spectralMeasure T hT xi) (coordFn T) u)
      = T (cyclicEmbedding T hT xi u) := by
  rw [cyclicEmbedding_intertwines_cfc T hT xi (coordFn T) u, cfcHom_coordFn]

/-! ## 3. Gluing the summand models -/

omit [CompleteSpace H] in
/-- Vectors of orthogonal subspaces are orthogonal. -/
theorem inner_eq_zero_of_le_orthogonal {M N : Submodule ℂ H} (h : M ≤ Nᗮ) {a b : H}
    (ha : a ∈ M) (hb : b ∈ N) : inner ℂ a b = 0 := by
  have h0 := (Submodule.mem_orthogonal N a).1 (h ha) b hb
  simpa [inner_eq_zero_symm] using h0

/-- The embeddings attached to an orthogonal cyclic family have orthogonal ranges. -/
theorem orthogonalFamily_cyclicEmbedding {S : Set H} (hS : OrthogonalCyclicFamily T hT S) :
    OrthogonalFamily ℂ (fun x : S => Lp ℂ 2 (spectralMeasure T hT (x : H)))
      (fun x : S => cyclicEmbedding T hT (x : H)) := by
  intro x y hxy u v
  have hle := hS.2 (x : H) x.2 (y : H) y.2 (Subtype.coe_injective.ne hxy)
  exact inner_eq_zero_of_le_orthogonal hle
    (mem_cyclicSubspace_cyclicEmbedding T hT (x : H) u)
    (mem_cyclicSubspace_cyclicEmbedding T hT (y : H) v)

include hT in
/-- **HEADLINE (the general spectral multiplication model).**  For every normal
operator `T` on a complex Hilbert space there is a family of Borel probability
measures `μₓ` on the spectrum of `T` and isometric embeddings `Vₓ : L²(μₓ) → H`
which exhibit `H` as the Hilbert sum of the spaces `L²(μₓ)` and carry multiplication
by the coordinate function into `T`.  Every normal operator is a direct sum of
multiplication operators; no cyclic vector is assumed. -/
theorem spectral_multiplication_model_general :
    ∃ (S : Set H) (mu : S → Measure (spectrum ℂ T))
      (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) (coordFn T) u) = T (V x u)) := by
  obtain ⟨S, hS, htop⟩ := exists_cyclic_decomposition T hT
  refine ⟨S, fun x => spectralMeasure T hT (x : H), fun x => cyclicEmbedding T hT (x : H),
    fun x => isProbabilityMeasure_spectralMeasure T hT (x : H) (hS.1 (x : H) x.2), ?_,
    fun x u => cyclicEmbedding_intertwines T hT (x : H) u⟩
  refine IsHilbertSum.mk (orthogonalFamily_cyclicEmbedding T hT hS) ?_
  have hrange : (⨆ x : S, LinearMap.range (cyclicEmbedding T hT (x : H)).toLinearMap)
      = ⨆ x ∈ S, cyclicSubspace T hT x := by
    rw [iSup_subtype]
    exact iSup_congr fun x => iSup_congr fun _ => range_cyclicEmbedding T hT x
  rw [hrange, htop]

/-! ## 4. The separable case: countably many summands -/

/-- Distinct members of an orthogonal cyclic family are orthogonal unit vectors. -/
theorem inner_eq_zero_of_orthogonalCyclicFamily {S : Set H} (hS : OrthogonalCyclicFamily T hT S)
    {x y : H} (hx : x ∈ S) (hy : y ∈ S) (hxy : x ≠ y) : inner ℂ x y = (0 : ℂ) :=
  inner_eq_zero_of_le_orthogonal (hS.2 x hx y hy hxy) (self_mem_cyclicSubspace T hT x)
    (self_mem_cyclicSubspace T hT y)

/-- Hence they are at distance `√2` from one another; in particular more than `1`
apart. -/
theorem one_lt_dist_of_orthogonalCyclicFamily {S : Set H} (hS : OrthogonalCyclicFamily T hT S)
    {x y : H} (hx : x ∈ S) (hy : y ∈ S) (hxy : x ≠ y) : 1 < dist x y := by
  have h := inner_eq_zero_of_orthogonalCyclicFamily T hT hS hx hy hxy
  have hxn : ‖x‖ = 1 := hS.1 x hx
  have hyn : ‖y‖ = 1 := hS.1 y hy
  have hneg : inner ℂ x (-y) = (0 : ℂ) := by simp [h]
  have h2 : ‖x + -y‖ * ‖x + -y‖ = 2 := by
    rw [norm_add_sq_eq_norm_sq_add_norm_sq_of_inner_eq_zero x (-y) hneg, hxn, norm_neg, hyn]
    norm_num
  have hd : dist x y = ‖x + -y‖ := by rw [dist_eq_norm, sub_eq_add_neg]
  nlinarith [norm_nonneg (x + -y), hd, h2]

/-- **On a separable space the decomposition is countable**: a family of unit vectors
with pairwise orthogonal cyclic subspaces is countable. -/
theorem countable_orthogonalCyclicFamily [TopologicalSpace.SeparableSpace H] {S : Set H}
    (hS : OrthogonalCyclicFamily T hT S) : S.Countable := by
  refine Set.PairwiseDisjoint.countable_of_isOpen (s := fun x : H => Metric.ball x (1 / 2)) ?_
    (fun x _ => Metric.isOpen_ball) (fun x _ => ⟨x, Metric.mem_ball_self (by norm_num)⟩)
  intro x hx y hy hxy
  refine Metric.ball_disjoint_ball ?_
  have := one_lt_dist_of_orthogonalCyclicFamily T hT hS hx hy hxy
  linarith

include hT in
/-- **HEADLINE (the separable case).**  On a separable complex Hilbert space every
normal operator is a *countable* direct sum of multiplication operators: there are
countably many Borel probability measures on the spectrum and isometric embeddings of
the corresponding `L²` spaces exhibiting the space as their Hilbert sum, with the
operator acting as multiplication by the coordinate function on each summand. -/
theorem spectral_multiplication_model_separable [TopologicalSpace.SeparableSpace H] :
    ∃ (S : Set H) (mu : S → Measure (spectrum ℂ T))
      (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      S.Countable ∧
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) (coordFn T) u) = T (V x u)) := by
  obtain ⟨S, hS, htop⟩ := exists_cyclic_decomposition T hT
  refine ⟨S, fun x => spectralMeasure T hT (x : H), fun x => cyclicEmbedding T hT (x : H),
    countable_orthogonalCyclicFamily T hT hS,
    fun x => isProbabilityMeasure_spectralMeasure T hT (x : H) (hS.1 (x : H) x.2), ?_,
    fun x u => cyclicEmbedding_intertwines T hT (x : H) u⟩
  refine IsHilbertSum.mk (orthogonalFamily_cyclicEmbedding T hT hS) ?_
  have hrange : (⨆ x : S, LinearMap.range (cyclicEmbedding T hT (x : H)).toLinearMap)
      = ⨆ x ∈ S, cyclicSubspace T hT x := by
    rw [iSup_subtype]
    exact iSup_congr fun x => iSup_congr fun _ => range_cyclicEmbedding T hT x
  rw [hrange, htop]

end BookProof.ChapterSpectralDirectSum

end
