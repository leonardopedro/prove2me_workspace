import Mathlib
import BookProof.ChapterShiftedQuadraticMatrixEsa
import BookProof.ChapterStoneEigenflow

/-!
# The inhomogeneous quadratic Hamiltonian with a **singular** quadratic form

`BookProof.ChapterShiftedQuadraticMatrixEsa` proves that for every real symmetric
**invertible** `A` and arbitrary real `b, b'` the operator

`H = ∑_{p,q} A_{pq}(π_pπ_q + x_px_q/4) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`,  `πᵢ = −i∂/∂xᵢ`,

is essentially self-adjoint on the translated, modulated Gauss–polynomial core `D_{a,k}`
with `a = −2A⁻¹b`, `k = −A⁻¹b'/2`.  Invertibility was used exactly once: to solve the
*classical equilibrium equations* `A a = −2b`, `A k = −b'/2`.  This module removes it.

The completion of the square only needs a *solution* of those two linear systems, not
uniqueness, so the natural hypothesis is solvability, and for a symmetric `A` solvability
is exactly orthogonality to the kernel:

* `equilibrium_orthogonal_to_kernel` — if `A a = w` then `w ⊥ ker A` (necessity; uses only
  symmetry of `A`);
* `exists_equilibrium` — conversely, if `w ⊥ ker A` then `A a = w` is solvable
  (sufficiency; proved from the spectral theorem for real symmetric matrices in the form
  `BookProof.QuadraticRotation.exists_rotConj_eigenvalues`, by inverting `A` on the
  non-degenerate eigendirections);
* `exists_equilibrium_iff` — the two together.

The consequences, for an **arbitrary** real symmetric `A` (invertible or not, of arbitrary
signature — elliptic, hyperbolic or degenerate):

* `shiftedHMatOp_symmetric_of_equilibrium`,
  `shiftedHMatOp_essentiallySelfAdjoint_of_equilibrium` — symmetry and essential
  self-adjointness on `D_{a,k}` for *any* solution `a, k` of the equilibrium equations;
* `exists_shiftedHMat_esa_of_kernel_orthogonal` — the headline in intrinsic form: if `b`
  and `b'` are orthogonal to `ker A`, a core exists on which `H` is symmetric,
  essentially self-adjoint and generates a complete unitary flow;
* `diagonal_degenerate_essentiallySelfAdjoint` — the concrete diagonal instance
  `∑ᵢ (cᵢ(πᵢ² + xᵢ²/4) + bᵢxᵢ + b'ᵢπᵢ)` with *some weights allowed to vanish*, provided the
  first-order coefficients vanish in the degenerate directions; this is exactly the case
  excluded by `BookProof.ShiftedQuadratic.shiftedHOp_essentiallySelfAdjoint`, which
  requires `cᵢ ≠ 0` for every `i`.

Finally the dynamics is made explicit, by feeding the Hermite eigenbasis into
`BookProof.StoneEigenflow`:

* `exists_shiftedHMat_diagonal_flow` — the unitary flow acts on the translated, modulated,
  rotated Hermite function `ψ_α` by the phase `e^{−iE_αt}`,
  `E_α = ∑ᵢ cᵢ(αᵢ + ½) + const`;
* `exists_shiftedH_diagonal_flow` — the same for the diagonal Hamiltonian of
  `BookProof.ShiftedQuadratic`.

## Honest boundary

Orthogonality of `b, b'` to `ker A` is *necessary* for this route and is not a technical
artefact of the proof: in a kernel direction the Hamiltonian degenerates to the first-order
operator `bᵢxᵢ + b'ᵢπᵢ`, which has no eigenvector in `L²` and is not diagonal in any
Hermite-type basis.  That case (free motion / a constant force in a null direction) is not
covered here.  Nothing here claims a general Faris–Lavine potential.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ShiftedQuadraticDegenerate

open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HyperbolicQuadratic
open BookProof.QuadraticRotation
open BookProof.ShiftedHermiteCore
open BookProof.ShiftedQuadratic
open BookProof.ShiftedQuadraticMatrix
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.StoneEigenflow

noncomputable section

variable {d : ℕ}

/-! ## 1. Solvability of the classical equilibrium equations -/

/-- **Necessity.**  If the equilibrium equation `A a = w` has a solution and `A` is
symmetric, then `w` is orthogonal to the kernel of `A`. -/
theorem equilibrium_orthogonal_to_kernel {A : Matrix (Fin d) (Fin d) ℝ}
    (hsym : ∀ i j, A i j = A j i) {a w : Fin d → ℝ} (ha : ∀ i, ∑ j, A i j * a j = w i)
    {v : Fin d → ℝ} (hv : ∀ i, ∑ j, A i j * v j = 0) :
    ∑ i, w i * v i = 0 := by
  have h1 : ∑ i, w i * v i = ∑ i, ∑ j, A i j * a j * v i := by
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [← ha i, Finset.sum_mul]
  have h2 : ∑ i, ∑ j, A i j * a j * v i = ∑ j, a j * ∑ i, A j i * v i := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => by rw [hsym i j]; ring
  rw [h1, h2]
  exact Finset.sum_eq_zero fun j _ => by rw [hv j, mul_zero]

/-- **Sufficiency.**  For a real symmetric `A`, every `w` orthogonal to `ker A` is in the
range of `A`: the classical equilibrium equation `A a = w` is solvable.  Proved by
diagonalizing `A` and inverting it on the non-degenerate eigendirections. -/
theorem exists_equilibrium {A : Matrix (Fin d) (Fin d) ℝ} (hA : A.IsHermitian)
    {w : Fin d → ℝ}
    (hw : ∀ v : Fin d → ℝ, (∀ i, ∑ j, A i j * v j = 0) → ∑ i, w i * v i = 0) :
    ∃ a : Fin d → ℝ, ∀ i, ∑ j, A i j * a j = w i := by
  classical
  obtain ⟨O, hO, hAO⟩ := exists_rotConj_eigenvalues hA
  set c := hA.eigenvalues with hc
  have hOOt : O * Oᵀ = 1 := by simpa using mul_eq_one_comm.mp hO
  have hAeq : A = O * Matrix.diagonal c * Oᵀ := by rw [hAO, rotConj_eq]
  have hAO' : A * O = O * Matrix.diagonal c := by
    rw [hAeq, Matrix.mul_assoc, Matrix.mul_assoc, hO, Matrix.mul_one]
  set u : Fin d → ℝ := Oᵀ *ᵥ w with hu
  have hker : ∀ i, c i = 0 → u i = 0 := by
    intro i hci
    have hv : A *ᵥ (O *ᵥ (Pi.single i (1 : ℝ))) = 0 := by
      rw [Matrix.mulVec_mulVec, hAO', ← Matrix.mulVec_mulVec]
      have hz : Matrix.diagonal c *ᵥ (Pi.single i (1 : ℝ)) = 0 := by
        rw [Matrix.mulVec_single]
        funext j
        by_cases h : j = i <;> simp [h, hci]
      rw [hz, Matrix.mulVec_zero]
    have hsum := hw _ (fun j => congrFun hv j)
    rw [hu]
    simp only [Matrix.mulVec, Matrix.transpose_apply, dotProduct]
    rw [← hsum]
    refine Finset.sum_congr rfl fun j _ => ?_
    simp [Matrix.mulVec_single]
    ring
  set y : Fin d → ℝ := fun i => if c i = 0 then 0 else u i / c i with hy
  refine ⟨O *ᵥ y, fun i => ?_⟩
  have hdy : Matrix.diagonal c *ᵥ y = u := by
    funext j
    rw [Matrix.mulVec_diagonal, hy]
    by_cases h : c j = 0
    · simp [h, hker j h]
    · simp only [h, if_false]
      field_simp
  have hfin : A *ᵥ (O *ᵥ y) = w := by
    rw [Matrix.mulVec_mulVec, hAO', ← Matrix.mulVec_mulVec, hdy, hu,
      Matrix.mulVec_mulVec, hOOt, Matrix.one_mulVec]
  calc ∑ j, A i j * (O *ᵥ y) j = (A *ᵥ (O *ᵥ y)) i := rfl
    _ = w i := by rw [hfin]

/-- **The solvability criterion.**  For a real symmetric `A`, the classical equilibrium
equation `A a = w` is solvable if and only if `w` is orthogonal to `ker A`. -/
theorem exists_equilibrium_iff {A : Matrix (Fin d) (Fin d) ℝ} (hA : A.IsHermitian)
    (w : Fin d → ℝ) :
    (∃ a : Fin d → ℝ, ∀ i, ∑ j, A i j * a j = w i)
      ↔ ∀ v : Fin d → ℝ, (∀ i, ∑ j, A i j * v j = 0) → ∑ i, w i * v i = 0 := by
  refine ⟨fun ⟨a, ha⟩ v hv => equilibrium_orthogonal_to_kernel (entries_symm hA) ha hv,
    fun hw => exists_equilibrium hA hw⟩

/-! ## 2. Symmetry and essential self-adjointness for an arbitrary symmetric `A` -/

/-- The Hamiltonian is symmetric on the translated, modulated core determined by *any*
solution of the classical equilibrium equations — no invertibility, no sign condition. -/
theorem shiftedHMatOp_symmetric_of_equilibrium {A : Matrix (Fin d) (Fin d) ℝ}
    (hA : A.IsHermitian) (b b' : Fin d → ℝ) (a k : Vd d)
    (ha : ∀ i, ∑ j, A i j * a j = -2 * b i)
    (hk : ∀ i, ∑ j, A i j * k j = -(b' i) / 2) :
    SymmetricOn (polyGaussCoreT a k) (shiftedHMatOp a k A b b') := by
  obtain ⟨O, hO, hAO⟩ := exists_rotConj_eigenvalues hA
  have hsym := entries_symm hA
  rw [hAO] at hsym ha hk ⊢
  exact shiftedHMatOp_rotConj_symmetric hO _ a k b b' hsym ha hk

/-- **The headline.**  For **every** real symmetric matrix `A` — invertible or singular, of
arbitrary signature — and arbitrary real `b, b'` admitting a classical equilibrium, the
inhomogeneous quadratic Hamiltonian

`H = ∑_{p,q} A_{pq}(π_pπ_q + x_px_q/4) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

is essentially self-adjoint on the translated, modulated Gauss–polynomial core `D_{a,k}`. -/
theorem shiftedHMatOp_essentiallySelfAdjoint_of_equilibrium {A : Matrix (Fin d) (Fin d) ℝ}
    (hA : A.IsHermitian) (b b' : Fin d → ℝ) (a k : Vd d)
    (ha : ∀ i, ∑ j, A i j * a j = -2 * b i)
    (hk : ∀ i, ∑ j, A i j * k j = -(b' i) / 2) :
    EssentiallySelfAdjointOn (polyGaussCoreT a k) (shiftedHMatOp a k A b b') := by
  obtain ⟨O, hO, hAO⟩ := exists_rotConj_eigenvalues hA
  have hsym := entries_symm hA
  rw [hAO] at hsym ha hk ⊢
  exact ⟨shiftedHMatOp_rotConj_deficiencyTrivialAt hO _ a k b b' hsym ha hk (by simp),
    shiftedHMatOp_rotConj_deficiencyTrivialAt hO _ a k b b' hsym ha hk (by simp)⟩

/-- **The headline in intrinsic form.**  If the first-order coefficients `b, b'` are
orthogonal to the kernel of the symmetric matrix `A` — the exact condition for the
classical equilibrium to exist — then a dense core exists on which the Hamiltonian is
symmetric, essentially self-adjoint, and generates a complete unitary flow. -/
theorem exists_shiftedHMat_esa_of_kernel_orthogonal {A : Matrix (Fin d) (Fin d) ℝ}
    (hA : A.IsHermitian) (b b' : Fin d → ℝ)
    (hb : ∀ v : Fin d → ℝ, (∀ i, ∑ j, A i j * v j = 0) → ∑ i, b i * v i = 0)
    (hb' : ∀ v : Fin d → ℝ, (∀ i, ∑ j, A i j * v j = 0) → ∑ i, b' i * v i = 0) :
    ∃ a k : Vd d,
      Dense ((polyGaussCoreT a k : Submodule ℂ (L2d d)) : Set (L2d d)) ∧
      SymmetricOn (polyGaussCoreT a k) (shiftedHMatOp a k A b b') ∧
      EssentiallySelfAdjointOn (polyGaussCoreT a k) (shiftedHMatOp a k A b b') ∧
      ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
        IsSelfAdjointExtension (shiftedHMatOp a k A b b') T.op ∧ IsStoneFlow T U := by
  obtain ⟨a0, ha0⟩ := exists_equilibrium hA (w := fun i => -2 * b i) (by
    intro v hv
    have := hb v hv
    calc ∑ i, (-2 * b i) * v i = -2 * ∑ i, b i * v i := by
          rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun i _ => by ring
      _ = 0 := by rw [this, mul_zero])
  obtain ⟨k0, hk0⟩ := exists_equilibrium hA (w := fun i => -(b' i) / 2) (by
    intro v hv
    have := hb' v hv
    calc ∑ i, (-(b' i) / 2) * v i = (-(1:ℝ)/2) * ∑ i, b' i * v i := by
          rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun i _ => by ring
      _ = 0 := by rw [this, mul_zero])
  refine ⟨(WithLp.toLp 2 a0 : Vd d), (WithLp.toLp 2 k0 : Vd d), polyGaussCoreT_dense _ _,
    shiftedHMatOp_symmetric_of_equilibrium hA b b' _ _ ha0 hk0,
    shiftedHMatOp_essentiallySelfAdjoint_of_equilibrium hA b b' _ _ ha0 hk0, ?_⟩
  exact exists_stone_flow_of_esa _ (polyGaussCoreT_dense _ _)
    (shiftedHMatOp_symmetric_of_equilibrium hA b b' _ _ ha0 hk0)
    (shiftedHMatOp_essentiallySelfAdjoint_of_equilibrium hA b b' _ _ ha0 hk0)

/-! ## 3. The concrete degenerate diagonal case -/

/-- The equilibrium vector of a diagonal quadratic form, with the degenerate directions
set to zero. -/
def diagShiftVec (c w : Fin d → ℝ) : Vd d :=
  (WithLp.toLp 2 (fun i => if c i = 0 then 0 else w i / c i) : Vd d)

theorem diagonal_mulVec_diagShiftVec {c w : Fin d → ℝ} (hcw : ∀ i, c i = 0 → w i = 0)
    (i : Fin d) : ∑ j, (Matrix.diagonal c) i j * (diagShiftVec c w) j = w i := by
  classical
  rw [Finset.sum_eq_single i (fun j _ hj => by simp [Ne.symm hj])
    (by simp)]
  by_cases h : c i = 0
  · simp [Matrix.diagonal_apply_eq, diagShiftVec, h, hcw i h]
  · simp only [Matrix.diagonal_apply_eq, diagShiftVec, WithLp.ofLp_toLp, h, if_false]
    field_simp

/-- **The degenerate diagonal Hamiltonian.**  For diagonal weights `c` with *some weights
allowed to vanish*, and first-order coefficients vanishing in those degenerate directions,
`∑ᵢ (cᵢ(πᵢ² + xᵢ²/4) + bᵢxᵢ + b'ᵢπᵢ)` is essentially self-adjoint on the translated,
modulated Gauss–polynomial core.  This is exactly the case excluded by
`BookProof.ShiftedQuadratic.shiftedHOp_essentiallySelfAdjoint`, which needs `cᵢ ≠ 0`. -/
theorem diagonal_degenerate_essentiallySelfAdjoint (c b b' : Fin d → ℝ)
    (hb : ∀ i, c i = 0 → b i = 0) (hb' : ∀ i, c i = 0 → b' i = 0) :
    EssentiallySelfAdjointOn
      (polyGaussCoreT (diagShiftVec c fun i => -2 * b i)
        (diagShiftVec c fun i => -(b' i) / 2))
      (shiftedHMatOp (diagShiftVec c fun i => -2 * b i)
        (diagShiftVec c fun i => -(b' i) / 2) (Matrix.diagonal c) b b') :=
  shiftedHMatOp_essentiallySelfAdjoint_of_equilibrium (Matrix.isHermitian_diagonal_iff.mpr
      (fun i => IsSelfAdjoint.all (c i))) b b' _ _
    (diagonal_mulVec_diagShiftVec fun i hi => by rw [hb i hi]; ring)
    (diagonal_mulVec_diagShiftVec fun i hi => by rw [hb' i hi]; norm_num)

/-! ## 4. Explicit dynamics on the Hermite eigenbasis -/

/-- **The flow in closed form.**  For a quadratic form `A = O diag(c) Oᵀ` with a classical
equilibrium `a, k`, the unitary Schrödinger flow generated by the Hamiltonian acts on the
translated, modulated, rotated Hermite function `ψ_α` by the phase `e^{−iE_αt}` with
`E_α = ∑ᵢ cᵢ(αᵢ + ½) + const`. -/
theorem exists_shiftedHMat_diagonal_flow {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (c : Fin d → ℝ) (a k : Vd d) (b b' : Fin d → ℝ)
    (hsym : ∀ i j, rotConj O c i j = rotConj O c j i)
    (ha : ∀ i, ∑ j, rotConj O c i j * a j = -2 * b i)
    (hk : ∀ i, ∑ j, rotConj O c i j * k j = -(b' i) / 2) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (shiftedHMatOp a k (rotConj O c) b b') T.op ∧
      IsStoneFlow T U ∧
      ∀ (α : Fin d →₀ ℕ) (t : ℝ),
        U t (hermiteTRLp O a k α)
          = Complex.exp (-(Complex.I * ((quadSymbol c α + matShiftConst a k b b' : ℝ) : ℂ) * t))
              • hermiteTRLp O a k α :=
  exists_diagonal_stone_flow _ (polyGaussCoreT_dense a k)
    (shiftedHMatOp_rotConj_symmetric hO c a k b b' hsym ha hk)
    ⟨shiftedHMatOp_rotConj_deficiencyTrivialAt hO c a k b b' hsym ha hk (by simp),
      shiftedHMatOp_rotConj_deficiencyTrivialAt hO c a k b b' hsym ha hk (by simp)⟩
    (fun α => (⟨hermiteTRLp O a k α, hermiteTRLp_mem_coreT O a k α⟩ : polyGaussCoreT a k))
    (fun α => quadSymbol c α + matShiftConst a k b b')
    (fun α => shiftedHMatOp_hermiteTRLp hO c a k b b' hsym ha hk α
      (hermiteTRLp_mem_coreT O a k α))

/-- The same for the diagonal Hamiltonian `∑ᵢ (cᵢ(πᵢ² + xᵢ²/4) + bᵢxᵢ + b'ᵢπᵢ)` of
`BookProof.ShiftedQuadratic`: the flow acts on the recentred, boosted Hermite function
`ψ_α` by the phase `e^{−iE_αt}`, `E_α = ∑ᵢ cᵢ(αᵢ + ½) + shiftConst`. -/
theorem exists_shiftedH_diagonal_flow (c b b' : Fin d → ℝ) (hc : ∀ i, c i ≠ 0) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension
        (shiftedHOp (shiftVec c b) (boostVec c b') c b b') T.op ∧
      IsStoneFlow T U ∧
      ∀ (α : Fin d →₀ ℕ) (t : ℝ),
        U t (hermiteTLp (shiftVec c b) (boostVec c b') α)
          = Complex.exp (-(Complex.I * ((quadSymbol c α + shiftConst c b b' : ℝ) : ℂ) * t))
              • hermiteTLp (shiftVec c b) (boostVec c b') α :=
  exists_diagonal_stone_flow _ (shiftedCore_dense c b b')
    (shiftedHOp_symmetric c b b' hc) (shiftedHOp_essentiallySelfAdjoint c b b' hc)
    (fun α => (⟨hermiteTLp (shiftVec c b) (boostVec c b') α,
      hermiteTLp_mem_coreT _ _ α⟩ : polyGaussCoreT (shiftVec c b) (boostVec c b')))
    (fun α => quadSymbol c α + shiftConst c b b')
    (fun α => shiftedHOp_hermiteTLp c b b' hc α (hermiteTLp_mem_coreT _ _ α))

end

end BookProof.ShiftedQuadraticDegenerate
