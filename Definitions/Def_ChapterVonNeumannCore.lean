import Definitions.Def_ChapterFriedrichsSquareFactorization
import Mathlib


/-!
# von Neumann's core theorem: `D(A* Ā)` is a core of `Ā`, and `(1 + A* Ā)⁻¹`

`BookProof.ChapterFriedrichsSquareFactorization` proves that the composite
`A* Ā` — the relation `factorRel A` — is the Friedrichs extension of `A²` for a
densely defined symmetric operator `A` with invariant domain, and that
`1 + A* Ā` is *surjective* (`exists_mem_factorRel_add`).  Two classical
complements of that theorem are proved here.

## The bounded inverse `(1 + A* Ā)⁻¹`

The solution of `x + A* Ā x = h` is also **unique**
(`eq_of_mem_factorRel_add_eq`), because the quadratic form of `A* Ā` is `‖Āx‖²`:
pairing `x + A* Ā x = h` with `x` gives `⟪x, h⟫ = ‖x‖² + ‖Āx‖²`, whence

* `‖x‖ ≤ ‖h‖` and `‖Āx‖ ≤ ‖h‖` (`norm_le_of_mem_factorRel_add`),
* `x = 0` when `h = 0` (`eq_zero_of_mem_factorRel_add_eq_zero`).

So `h ↦ x` is a well-defined linear map `resLin A`, everywhere defined, bounded
by `1` — the continuous operator **`resCLM A`** with `‖resCLM A‖ ≤ 1` — and it
is a two-sided inverse of `1 + A* Ā` (`resLin_left_inverse`,
`resLin_right_inverse`).  In particular `D(A* Ā)`, the domain `frDom A`, is
**dense** (`frDom_dense`): a vector orthogonal to it is orthogonal to `x` for the
solution of `x + A* Ā x = h` with `h` the vector itself, and the same quadratic
form kills it.

## The core theorem

**`topologicalClosure_coreGraph`** — the part of the closed graph of `Ā` lying
over `D(A* Ā)`, i.e. `coreGraph A = clGraph A ⊓ (frDom A ×  F)`, is dense in the
whole closed graph.  Equivalently, in operator form, `Ā` restricted to `D(A* Ā)`
(`coreRes A`) has the same closure as `A` (`clGraph_coreRes`) and is a core of
the closure `clExt A` (`isCoreOf_coreRes`).

The proof is von Neumann's: work in the Hilbert direct sum `F ⊕₂ F`, where the
graph inner product is the ambient one.  If `q = (x, w)` lies in the closed graph
and is orthogonal to the graph over `D(A* Ā)`, then for every `(a, z) ∈ A* Ā`
with `(a, y) ∈ clGraph A` orthogonality reads `⟪a, x⟫ + ⟪y, w⟫ = 0`, and the
adjoint relation `(y, z)` turns `⟪y, w⟫` into `⟪z, x⟫`; hence
`⟪a + z, x⟫ = 0`.  Since `1 + A* Ā` is surjective, `a + z` runs over the whole
space, so `x = 0`, and then `w = 0` by closability
(`eq_zero_of_mem_clLp_of_orthogonal`).  A trivial orthogonal-projection argument
turns that into density (`clLp_le_topologicalClosure_coreLp`), and the
homeomorphism `F ⊕₂ F ≅ F × F` transports the statement back to `F × F`.

Combined with `BookProof.ClosureUniqueness.factorGraph_eq_of_clGraph_eq`, the
Friedrichs extension of `A²` may therefore be computed from the core `D(A* Ā)`
itself (`factorGraph_coreRes`).

Hypotheses: `F` is a complex Hilbert space, `A` is symmetric on a dense domain
`D`.  No invariance of `D` is needed anywhere in this module — `A²` never
appears; only the closure `Ā`, the adjoint `A*` and their composite do.
-/

namespace BookProof.VonNeumannCore

open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

/-- The quadratic-form identity for `1 + A* Ā`. -/
theorem inner_fst_add_self {A : D →ₗ[ℂ] F} {p : F × F} (hp : p ∈ factorRel A) :
    ∃ y : F, (p.1, y) ∈ clGraph A ∧
      (inner ℂ p.1 (p.1 + p.2) : ℂ) = ((‖p.1‖ ^ 2 + ‖y‖ ^ 2 : ℝ) : ℂ) := by
  obtain ⟨y, hy, hval⟩ := factorGraph_quadForm (A := A) (p := p) hp
  refine ⟨y, hy, ?_⟩
  have h1 : (inner ℂ p.1 p.1 : ℂ) = ((‖p.1‖ ^ 2 : ℝ) : ℂ) := by
    rw [inner_self_eq_norm_sq_to_K]
    norm_cast
  rw [inner_add_right, h1, hval, ← Complex.ofReal_add]

theorem eq_zero_of_mem_factorRel_add_eq_zero {A : D →ₗ[ℂ] F} {p : F × F} (hp : p ∈ factorRel A)
    (hsum : p.1 + p.2 = 0) : p = 0 := by
  obtain ⟨y, -, hval⟩ := inner_fst_add_self hp
  rw [hsum, inner_zero_right] at hval
  have hre : (0 : ℝ) = ‖p.1‖ ^ 2 + ‖y‖ ^ 2 := by
    have h0 := congrArg Complex.re hval
    rwa [Complex.zero_re, Complex.ofReal_re] at h0
  have h1 : p.1 = 0 := by
    have : ‖p.1‖ = 0 := by nlinarith [norm_nonneg p.1, norm_nonneg y]
    simpa using this
  have h2 : p.2 = 0 := by
    have := hsum
    rw [h1, zero_add] at this
    exact this
  exact Prod.ext h1 h2

/-- Uniqueness of the solution of `x + A* Ā x = h`. -/
theorem eq_of_mem_factorRel_add_eq {A : D →ₗ[ℂ] F} {p q : F × F} (hp : p ∈ factorRel A)
    (hq : q ∈ factorRel A) {h : F} (hps : p.1 + p.2 = h) (hqs : q.1 + q.2 = h) : p = q := by
  have hsub : p - q ∈ factorRel A := (factorRel A).sub_mem hp hq
  have hsum : (p - q).1 + (p - q).2 = 0 := by
    simp only [Prod.fst_sub, Prod.snd_sub]
    rw [show p.1 - q.1 + (p.2 - q.2) = (p.1 + p.2) - (q.1 + q.2) by abel, hps, hqs, sub_self]
  have := eq_zero_of_mem_factorRel_add_eq_zero hsub hsum
  exact sub_eq_zero.1 this

/-- `‖(1 + A* Ā)⁻¹ h‖ ≤ ‖h‖` and `‖Ā (1 + A* Ā)⁻¹ h‖ ≤ ‖h‖`. -/
theorem norm_le_of_mem_factorRel_add {A : D →ₗ[ℂ] F} {p : F × F} (hp : p ∈ factorRel A) {h : F}
    (hsum : p.1 + p.2 = h) :
    ‖p.1‖ ≤ ‖h‖ ∧ ∃ y : F, (p.1, y) ∈ clGraph A ∧ ‖y‖ ≤ ‖h‖ := by
  obtain ⟨y, hy, hval⟩ := inner_fst_add_self hp
  rw [hsum] at hval
  have hkey : ‖p.1‖ ^ 2 + ‖y‖ ^ 2 ≤ ‖p.1‖ * ‖h‖ := by
    have hre : (inner ℂ p.1 h : ℂ).re = ‖p.1‖ ^ 2 + ‖y‖ ^ 2 := by
      rw [hval, Complex.ofReal_re]
    have hle : (inner ℂ p.1 h : ℂ).re ≤ ‖p.1‖ * ‖h‖ := by
      simpa using re_inner_le_norm (𝕜 := ℂ) p.1 h
    rw [hre] at hle
    linarith
  have h1 : ‖p.1‖ ≤ ‖h‖ := by
    rcases eq_or_lt_of_le (norm_nonneg p.1) with hz | hz
    · rw [← hz]; exact norm_nonneg h
    · nlinarith [norm_nonneg y]
  refine ⟨h1, y, hy, ?_⟩
  have hsq : ‖y‖ ^ 2 ≤ ‖h‖ ^ 2 := by nlinarith [norm_nonneg p.1, norm_nonneg h]
  nlinarith [norm_nonneg y, norm_nonneg h]



section Complete

variable [CompleteSpace F]

/-! ## The bounded inverse `(1 + A* Ā)⁻¹` -/

/-- The unique solution pair of `x + A* Ā x = h`. -/
noncomputable def resPair (A : D →ₗ[ℂ] F) (h : F) : F × F :=
  Classical.choose (exists_mem_factorRel_add A h)

theorem resPair_mem (A : D →ₗ[ℂ] F) (h : F) : resPair A h ∈ factorRel A :=
  (Classical.choose_spec (exists_mem_factorRel_add A h)).1

theorem resPair_add (A : D →ₗ[ℂ] F) (h : F) : (resPair A h).1 + (resPair A h).2 = h :=
  (Classical.choose_spec (exists_mem_factorRel_add A h)).2

theorem resPair_unique {A : D →ₗ[ℂ] F} {h : F} {p : F × F} (hp : p ∈ factorRel A)
    (hsum : p.1 + p.2 = h) : resPair A h = p :=
  eq_of_mem_factorRel_add_eq (resPair_mem A h) hp (resPair_add A h) hsum

/-- `(1 + A* Ā)⁻¹` as a linear map. -/
noncomputable def resLin (A : D →ₗ[ℂ] F) : F →ₗ[ℂ] F where
  toFun h := (resPair A h).1
  map_add' h k := by
    have : resPair A (h + k) = resPair A h + resPair A k := by
      refine resPair_unique ((factorRel A).add_mem (resPair_mem A h) (resPair_mem A k)) ?_
      have h1 := resPair_add A h
      have h2 := resPair_add A k
      simp only [Prod.fst_add, Prod.snd_add]
      rw [show (resPair A h).1 + (resPair A k).1 + ((resPair A h).2 + (resPair A k).2)
          = ((resPair A h).1 + (resPair A h).2) + ((resPair A k).1 + (resPair A k).2) by abel,
        h1, h2]
    rw [this]
    rfl
  map_smul' c h := by
    have : resPair A (c • h) = c • resPair A h := by
      refine resPair_unique ((factorRel A).smul_mem c (resPair_mem A h)) ?_
      simp only [Prod.smul_fst, Prod.smul_snd, ← smul_add, resPair_add A h]
    rw [this]
    rfl





theorem norm_resLin_le (A : D →ₗ[ℂ] F) (h : F) : ‖resLin A h‖ ≤ ‖h‖ :=
  (norm_le_of_mem_factorRel_add (resPair_mem A h) (resPair_add A h)).1

/-- **`(1 + A* Ā)⁻¹` is everywhere defined and a contraction.** -/
noncomputable def resCLM (A : D →ₗ[ℂ] F) : F →L[ℂ] F :=
  (resLin A).mkContinuous 1 (fun h => by simpa using norm_resLin_le A h)











/-! ## The domain of `A* Ā` is dense -/





/-! ## von Neumann's core theorem -/

end Complete

/-- The graph of `Ā` restricted to the domain of `A* Ā`. -/
def coreGraph (A : D →ₗ[ℂ] F) : Submodule ℂ (F × F) :=
  clGraph A ⊓ (frDom A).comap (LinearMap.fst ℂ F F)





/-- The same graph, inside the Hilbert direct sum `F ⊕₂ F`. -/
def coreLp (A : D →ₗ[ℂ] F) : Submodule ℂ (WithLp 2 (F × F)) :=
  (coreGraph A).comap (WithLp.linearEquiv 2 ℂ (F × F)).toLinearMap

/-- The closed graph, inside the Hilbert direct sum `F ⊕₂ F`. -/
def clLp (A : D →ₗ[ℂ] F) : Submodule ℂ (WithLp 2 (F × F)) :=
  (clGraph A).comap (WithLp.linearEquiv 2 ℂ (F × F)).toLinearMap









section Complete2

variable [CompleteSpace F]







/-! ## Operator form -/

/-- `Ā` restricted to the domain of `A* Ā`. -/
noncomputable def coreRes (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D A) :
    frDom A →ₗ[ℂ] F :=
  (clExt A hdense hsym).comp (Submodule.inclusion (frDom_le_clDom A))













end Complete2

end BookProof.VonNeumannCore
