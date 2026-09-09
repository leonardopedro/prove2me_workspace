import Mathlib
import BookProof.ChapterF1

/-!
# Chapter F3 — Quantum Flow Matching: Fock encoding & training (roadmap N14, §0 S7)

This file formalizes the algebraic / inner-product core of the *Quantum Flow
Matching* (QFM) algorithm (source `RiemannProof/QFM.tex`; reference
implementation `../unfer/qfm/`).  It follows §0 S7 of the roadmap (the
Mehler/Kopperman generative flow) and **reuses N12's number operator**
`BookProof.ChapterF1.numberOp` (`numberOp_monomial : N Xⁿ = n·Xⁿ`).

## Deliverables (this file)

* **F2.3 — orthogonal-Fock disjoint-support identities** (§5.1): packets with
  a.e.-disjoint supports have zero pointwise product (`disjoint_support_mul`,
  `disjoint_support_inner_zero`) — the "zero data loss" claim as a theorem.
* **F2.4 — diagonal-Gram closed-form training** (§5.2, the `O(M)` payoff):
  for a pairwise-orthogonal family `gⱼ`, the least-squares coefficients
  `αₖ = ⟪gₖ, b⟫/‖gₖ‖²` make the residual orthogonal to every `gₖ`
  (`diagonal_gram_residual_orthogonal`) — the defining property of the
  minimizer / orthogonal projection.
* **F2.6 — the vacuum projector `|0⟩⟨0|`** (§5.3): the rank-one map
  `projOnto ψ : s ↦ ⟪ψ, s⟫ • ψ` is idempotent for a unit `ψ`
  (`projOnto_idempotent`), self-adjoint (`projOnto_isSymmetric`), and equals the
  Mathlib orthogonal projection onto `ℂ ∙ ψ` (`projOnto_eq_starProjection`).
* **F2.7 — the diagonal generator's eigenstates** (§5.5): direct reuse of N12 —
  the vacuum `1` is annihilated (`diagGen_vacuum`) and the monomials `Xⁿ` are
  eigenvectors (`diagGen_eigenstate`) of `a·N̂`.
* **F2.8 — the Mehler overlap and the dressed-vacuum Bessel bound** (§6): the
  single-arc integral `mehler_arc_integral`, finite-product positivity of the
  overlaps `overlap_prod_pos`, and the key bound `Σⱼ εⱼ² ≤ 1`
  (`dressed_vacuum_bessel`) — exactly Bessel's inequality.
* **F2.9 — the Mehler projector as off-diagonal generator** (§5.3, §8): the
  channel matrix elements `⟪xᵢ, H₀ xⱼ⟫ = conj εᵢ · εⱼ` (`mehler_projector_matrix`).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); **no `EXTERNAL` hypothesis**.  Cites `../unfer` crates
`qfm/src/potential.rs`, `nested_fock_algebra` `ProjectVacuum`/`ProjectOnto`,
`qfm_hamiltonian`.
-/

open scoped BigOperators
open Polynomial

namespace BookProof.ChapterF3

noncomputable section

/-! ## F2.3 — orthogonal-Fock disjoint-support identities (`qfm/src/potential.rs`) -/

/-
**F2.3**: two functions with disjoint supports have zero pointwise product.
-/
theorem disjoint_support_mul {α : Type*} (f g : α → ℂ)
    (h : Disjoint (Function.support f) (Function.support g)) : f * g = 0 := by
  ext x;
  by_cases hx : f x = 0 <;> simp_all [ Function.mem_support, Set.disjoint_left ]

/-
**F2.3** (L² orthogonality): packets with a.e.-disjoint supports are
orthogonal in `L²`, `∫ conj (f x) · g x ∂μ = 0`, since the integrand vanishes
pointwise.
-/
theorem disjoint_support_inner_zero {α : Type*} [MeasurableSpace α] (μ : MeasureTheory.Measure α)
    (f g : α → ℂ) (h : Disjoint (Function.support f) (Function.support g)) :
    ∫ x, (starRingEnd ℂ) (f x) * g x ∂μ = 0 := by
  convert MeasureTheory.integral_eq_zero_of_ae ( Filter.Eventually.of_forall fun x => ?_ );
  by_cases hx : f x = 0 <;> by_cases hx' : g x = 0 <;> simp_all [ Set.disjoint_left ]

/-! ## F2.4 — the diagonal-Gram closed-form training solution (`O(M)` payoff) -/

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-
**F2.4**: for a pairwise-orthogonal family `g` of nonzero vectors, the
least-squares coefficients `αⱼ = ⟪gⱼ, b⟫/‖gⱼ‖²` (the per-coordinate closed form)
make the residual `b − Σⱼ αⱼ gⱼ` orthogonal to every `gₖ` — the normal
equations of the CFM training problem decouple, giving the `O(M)` solution.
-/
theorem diagonal_gram_residual_orthogonal {ι : Type*} [Fintype ι]
    (g : ι → E) (b : E)
    (horth : ∀ i j, i ≠ j → inner (𝕜 := ℂ) (g i) (g j) = 0)
    (hne : ∀ i, g i ≠ 0) (k : ι) :
    inner (𝕜 := ℂ) (g k)
      (b - ∑ j, ((inner (𝕜 := ℂ) (g j) b) / ((‖g j‖ : ℂ) ^ 2)) • g j) = 0 :=
    by
  simp only [CStarModule.inner_sub_right, CStarModule.inner_sum_right,
      CStarModule.inner_op_smul_right] ;
  rw [Finset.sum_eq_single k]
    <;> simp_all only [ne_eq, div_eq_inv_mul, inner_self_eq_norm_sq_to_K, Complex.coe_algebraMap,
          mul_assoc, mul_left_comm, OfNat.ofNat_ne_zero, not_false_eq_true,
          pow_eq_zero_iff, Complex.ofReal_eq_zero, norm_eq_zero, inv_mul_cancel₀,
          mul_one, sub_self, Finset.mem_univ, mul_eq_zero, inv_eq_zero, false_or,
          forall_const, not_true_eq_false, IsEmpty.forall_iff]
  exact fun i hi => Or.inr ( horth _ _ ( Ne.symm hi ) )

/-! ## F2.6 — the vacuum projector `|0⟩⟨0|` (`nested_fock_algebra` `ProjectVacuum`) -/

/-- The rank-one "project-onto-`ψ`" operator `s ↦ ⟪ψ, s⟫ • ψ`
(`../unfer` `ProjectOnto`). -/
def projOnto (ψ : E) : E →L[ℂ] E := (innerSL ℂ ψ).smulRight ψ

@[simp] theorem projOnto_apply (ψ s : E) : projOnto ψ s = (inner (𝕜 := ℂ) ψ s) • ψ := rfl

/-
**F2.6** (idempotency): for a unit vector `ψ`, `projOnto ψ` is idempotent
(`P ∘ P = P`) — the rank-1 projector shortcut.
-/
theorem projOnto_idempotent {ψ : E} (hψ : ‖ψ‖ = 1) (s : E) :
    projOnto ψ (projOnto ψ s) = projOnto ψ s := by
  simp [ hψ, inner_self_eq_norm_sq_to_K ]

/-
**F2.6** (self-adjointness): `projOnto ψ` is symmetric,
`⟪projOnto ψ x, y⟫ = ⟪x, projOnto ψ y⟫`.
-/
theorem projOnto_isSymmetric (ψ : E) (x y : E) :
    inner (𝕜 := ℂ) (projOnto ψ x) y = inner (𝕜 := ℂ) x (projOnto ψ y) := by
  simp [projOnto]

/-
**F2.6** (identification with the Mathlib projection): for a unit `ψ`,
`projOnto ψ` is the orthogonal projection onto the line `ℂ ∙ ψ`.
-/
theorem projOnto_eq_starProjection {ψ : E} (hψ : ‖ψ‖ = 1) (s : E) :
    projOnto ψ s = (Submodule.span ℂ {ψ}).starProjection s := by
  rw [ Submodule.starProjection_singleton ] ; aesop

/-! ## F2.7 — the diagonal generator's eigenstates (direct N12 reuse) -/

/-
**F2.7** (vacuum): the diagonal generator `a·N̂` annihilates the vacuum
`|0⟩ = 1`.  (`N̂ 1 = 0`.)
-/
theorem diagGen_vacuum (a : ℂ) : (a • ChapterF1.numberOp) (1 : ℂ[X]) = 0 := by
  convert congr_arg ( fun x : ℂ[X] => a • x ) ( ChapterF1.numberOp_monomial 0 ) using 1;
  norm_num

/-
**F2.7** (eigenstates): the monomials `Xⁿ = |xₙ⟩` are eigenvectors of the
diagonal generator `a·N̂` with eigenvalue `a·n` — direct reuse of N12's
`numberOp_monomial`.  Hence the Born populations are stationary (phase-only
evolution).
-/
theorem diagGen_eigenstate (a : ℂ) (n : ℕ) :
    (a • ChapterF1.numberOp) (X ^ n) = (a * n) • X ^ n :=
  by
  convert congr_arg (fun x => a • x) (ChapterF1.numberOp_monomial n) using 1
    ; norm_num [mul_assoc, smul_smul]

/-! ## F2.8 — the Mehler overlap and the dressed-vacuum Bessel bound -/

/-
**F2.8** (single-arc overlap integral): integrating the constant Mehler
amplitude `√(1/w)·√(1/2π)` over an arc of angular width `w` gives `√(w/2π)`.
-/
theorem mehler_arc_integral (w : ℝ) (hw : 0 < w) :
    (∫ _x in (0 : ℝ)..w, Real.sqrt (1 / w) * Real.sqrt (1 / (2 * Real.pi)))
      = Real.sqrt (w / (2 * Real.pi)) := by
  norm_num [ hw.le, mul_div_mul_comm, Real.mul_self_sqrt, Real.pi_pos.le ];
  grind

/-
**F2.8** (positivity, the Kakutani-dichotomy point): a *finite* product of
strictly positive single-arc overlaps is strictly positive — the overlap
`εⱼ = ∏ᵢ √(w_{j,i}/2π) > 0`.  (An infinite product of `< 1` factors could
vanish; finiteness rules that out.)
-/
theorem overlap_prod_pos {ι : Type*} (s : Finset ι) (w : ι → ℝ) (hw : ∀ i ∈ s, 0 < w i) :
    0 < ∏ i ∈ s, Real.sqrt (w i / (2 * Real.pi)) := by
  exact Finset.prod_pos fun i hi => Real.sqrt_pos.mpr ( div_pos ( hw i hi ) ( by positivity ) )

variable {E' : Type*} [NormedAddCommGroup E'] [InnerProductSpace ℂ E']

/-
**F2.8** (the dressed-vacuum Bessel bound `Σⱼ εⱼ² ≤ 1`): for an orthonormal
channel family `x : ι → E'` and a unit vacuum vector `v`, the overlaps
`εⱼ = ⟪xⱼ, v⟫` satisfy `Σⱼ ‖εⱼ‖² ≤ 1`.  This is exactly Bessel's inequality and
makes the dressed vacuum `c₀|vac⟩ + Σ εⱼ Bⱼ†|vac⟩` (with `c₀ = √(1−Σεⱼ²)`)
well-defined and unit-norm.
-/
theorem dressed_vacuum_bessel {ι : Type*} (x : ι → E') (hx : Orthonormal ℂ x)
    (v : E') (hv : ‖v‖ = 1) (s : Finset ι) :
    ∑ j ∈ s, ‖inner (𝕜 := ℂ) (x j) v‖ ^ 2 ≤ 1 := by
  convert hx.sum_inner_products_le v using 1;
  rw [ hv, one_pow ]

/-! ## F2.9 — the Mehler projector as the off-diagonal generator -/

/-
**F2.9**: the channel matrix elements of the vacuum projector
`H₀ = |v⟩⟨v|` are `⟪xᵢ, H₀ xⱼ⟫ = conj(⟪v, xᵢ⟫) · ⟪v, xⱼ⟫ = conj εᵢ · εⱼ`
(with `εₖ = ⟪v, xₖ⟫`).  A one-line corollary of F2.6: the projector is by itself
an off-diagonal generator.
-/
theorem mehler_projector_matrix (v xi xj : E') :
    inner (𝕜 := ℂ) xi (projOnto v xj)
      = (starRingEnd ℂ) (inner (𝕜 := ℂ) v xi) * inner (𝕜 := ℂ) v xj := by
  simp [ projOnto ];
  ring

end

end BookProof.ChapterF3
