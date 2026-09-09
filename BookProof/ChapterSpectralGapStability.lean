import Mathlib

/-!
# Chapter SpectralGapStability — a spectral gap survives a norm limit

`CONSOLIDATED_PLAN.md` §13.7 records one missing leg of the mass-gap path: the passage
from the truncated Hamiltonian to the continuum needs a *gap-preserving* convergence
statement.  This chapter proves the abstract core of such a statement, for bounded
self-adjoint operators and operator-norm convergence.

The quantitative form of "the operator has a spectral gap at `λ`" used here is
`GapAt A lam d`: `d‖x‖ ≤ ‖Ax − λx‖` for every `x`, i.e. `λ` admits no approximate
eigenvector to accuracy better than `d`.  For a bounded self-adjoint operator this is
exactly `dist(λ, spectrum) ≥ d` — the direction proved below is the one the application
needs: a quantitative gap keeps `λ` out of the spectrum.

## Deliverables

* `GapAt`, `gapAt_perturb` — a quantitative gap degrades by at most the perturbation:
  `GapAt A lam d` and `‖A − B‖ ≤ ε` give `GapAt B lam (d − ε)`.
* `gapAt_of_tendsto` — **a uniform gap survives an operator-norm limit**, with no loss:
  if every `Aₘ` has gap `d` at `λ` and `‖Aₘ − B‖ → 0`, then `B` has gap `d` at `λ`.
* `notMem_spectrum_of_gapAt` — a positive quantitative gap at a real `λ` keeps `λ` out of
  the spectrum of a bounded self-adjoint operator (injectivity from the bound, closed
  range from the same bound, dense range from symmetry) — and its converse
  `exists_gapAt_of_notMem_spectrum`, so the two notions really do agree.
* `notMem_spectrum_of_uniform_gap` and `spectrum_disjoint_of_uniform_window` — the
  gap-preserving conclusion: if the approximants have a uniform gap on an interval and
  converge in operator norm, the limit has no spectrum in that interval.

## Honest boundary

This is a statement about **operator-norm** convergence of *bounded* operators.  The
continuum leg of §13 needs it for the truncation family in the norm-resolvent sense, and
whether the truncations converge that way is exactly the open analytic question; nothing
here asserts that they do.  What the chapter supplies is the implication: *given* such a
convergence, the certified gap of the approximants is inherited by the limit.
-/

noncomputable section

namespace BookProof.SpectralGapStability

open scoped InnerProductSpace
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- **A quantitative spectral gap at `λ`**: no vector is moved by less than `d‖x‖` by
`A − λ`.  For a bounded self-adjoint operator this says `dist(λ, spectrum A) ≥ d`. -/
def GapAt (A : F →L[ℂ] F) (lam d : ℝ) : Prop :=
  ∀ x : F, d * ‖x‖ ≤ ‖A x - (lam : ℂ) • x‖

omit [CompleteSpace F] in
/-- A quantitative gap degrades by at most the size of the perturbation. -/
theorem gapAt_perturb {A B : F →L[ℂ] F} {lam d eps : ℝ}
    (h : GapAt A lam d) (hAB : ‖A - B‖ ≤ eps) : GapAt B lam (d - eps) := by
  intro x
  have h1 : ‖A x - B x‖ ≤ eps * ‖x‖ := by
    have := (A - B).le_opNorm x
    have hle : ‖A - B‖ * ‖x‖ ≤ eps * ‖x‖ := by
      exact mul_le_mul_of_nonneg_right hAB (norm_nonneg x)
    simpa [ContinuousLinearMap.sub_apply] using this.trans hle
  have h2 : ‖A x - (lam : ℂ) • x‖ ≤ ‖B x - (lam : ℂ) • x‖ + ‖A x - B x‖ := by
    have : A x - (lam : ℂ) • x = (B x - (lam : ℂ) • x) + (A x - B x) := by abel
    rw [this]
    exact norm_add_le _ _
  have h3 := h x
  have : (d - eps) * ‖x‖ = d * ‖x‖ - eps * ‖x‖ := by ring
  rw [this]
  linarith

omit [CompleteSpace F] in
/-- **A uniform quantitative gap survives an operator-norm limit**, with no loss: the
limit has the same gap `d`, not merely `d − ε`. -/
theorem gapAt_of_tendsto {A : ℕ → F →L[ℂ] F} {B : F →L[ℂ] F} {lam d : ℝ}
    (hA : ∀ m, GapAt (A m) lam d)
    (hconv : Tendsto (fun m => ‖A m - B‖) atTop (𝓝 0)) : GapAt B lam d := by
  intro x
  refine le_of_forall_pos_le_add ?_
  intro eps heps
  have hpos : 0 < eps / (‖x‖ + 1) := by positivity
  have hev : ∀ᶠ m in atTop, ‖A m - B‖ < eps / (‖x‖ + 1) :=
    hconv.eventually (gt_mem_nhds hpos)
  obtain ⟨m, hm⟩ := hev.exists
  have hgap := gapAt_perturb (A := A m) (B := B) (lam := lam) (d := d)
    (eps := eps / (‖x‖ + 1)) (hA m) hm.le x
  have hx : (0 : ℝ) ≤ ‖x‖ := norm_nonneg x
  have hsmall : eps / (‖x‖ + 1) * ‖x‖ ≤ eps := by
    rw [div_mul_eq_mul_div, div_le_iff₀ (by positivity)]
    nlinarith
  have : (d - eps / (‖x‖ + 1)) * ‖x‖ = d * ‖x‖ - eps / (‖x‖ + 1) * ‖x‖ := by ring
  rw [this] at hgap
  linarith

/-- A positive quantitative gap at a real `λ` keeps `λ` out of the spectrum of a bounded
self-adjoint operator. -/
theorem notMem_spectrum_of_gapAt {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) {lam d : ℝ}
    (hd : 0 < d) (h : GapAt A lam d) : (lam : ℂ) ∉ spectrum ℂ A := by
  set B : F →L[ℂ] F := A - (lam : ℂ) • (1 : F →L[ℂ] F) with hB
  have hBapp : ∀ x, B x = A x - (lam : ℂ) • x := by
    intro x; simp [hB]
  have hBx : ∀ x, d * ‖x‖ ≤ ‖B x‖ := by
    intro x; rw [hBapp x]; exact h x
  -- injectivity
  have hinj : Function.Injective B := by
    rw [injective_iff_map_eq_zero]
    intro x hx
    have := hBx x
    rw [hx, norm_zero] at this
    have : ‖x‖ ≤ 0 := by nlinarith [norm_nonneg x]
    simpa using le_antisymm this (norm_nonneg x)
  -- closed range
  have hanti : AntilipschitzWith ⟨d⁻¹, (inv_pos.2 hd).le⟩ B := by
    refine AddMonoidHomClass.antilipschitz_of_bound B ?_
    intro x
    have := hBx x
    rw [NNReal.coe_mk, inv_mul_eq_div, le_div_iff₀ hd]
    linarith
  have hclosed : IsClosed (Set.range B) := hanti.isClosed_range B.lipschitz.uniformContinuous
  -- symmetry
  have hAsym := ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp hA
  have hsym : ∀ x y : F, (inner ℂ (B x) y : ℂ) = inner ℂ x (B y) := by
    intro x y
    have hA' : (inner ℂ (A x) y : ℂ) = inner ℂ x (A y) := hAsym x y
    rw [hBapp, hBapp, inner_sub_left, inner_sub_right, hA', inner_smul_left,
      inner_smul_right, Complex.conj_ofReal]
  -- dense range, hence surjectivity
  have hrangeSet : (LinearMap.range (B : F →ₗ[ℂ] F) : Set F) = Set.range B := by
    ext y; simp [LinearMap.mem_range]
  have hrangeClosed : IsClosed (LinearMap.range (B : F →ₗ[ℂ] F) : Set F) := by
    rw [hrangeSet]; exact hclosed
  have hcompl : (LinearMap.range (B : F →ₗ[ℂ] F))ᗮ = ⊥ := by
    rw [Submodule.eq_bot_iff]
    intro y hy
    have hzero : ∀ x : F, (inner ℂ (B x) y : ℂ) = 0 := by
      intro x
      exact hy (B x) ⟨x, rfl⟩
    have hBy : (inner ℂ (B y) (B y) : ℂ) = 0 := by
      have h1 := hzero (B y)
      rwa [hsym (B y) y] at h1
    have : B y = 0 := by
      simpa using inner_self_eq_zero.mp hBy
    have hnorm := hBx y
    rw [this, norm_zero] at hnorm
    have : ‖y‖ ≤ 0 := by nlinarith [norm_nonneg y]
    simpa using le_antisymm this (norm_nonneg y)
  have hsurj : Function.Surjective B := by
    letI : IsClosed (LinearMap.range (B : F →ₗ[ℂ] F) : Set F) := hrangeClosed
    haveI : CompleteSpace (LinearMap.range (B : F →ₗ[ℂ] F)) := IsClosed.completeSpace_coe
    haveI := Submodule.HasOrthogonalProjection.ofCompleteSpace
      (LinearMap.range (B : F →ₗ[ℂ] F))
    have htop : LinearMap.range (B : F →ₗ[ℂ] F) = ⊤ := Submodule.orthogonal_eq_bot_iff.mp hcompl
    intro y
    have : y ∈ LinearMap.range (B : F →ₗ[ℂ] F) := by rw [htop]; trivial
    obtain ⟨x, hx⟩ := this
    exact ⟨x, hx⟩
  have hunitB : IsUnit B := ContinuousLinearMap.isUnit_iff_bijective.mpr ⟨hinj, hsurj⟩
  rw [spectrum.mem_iff]
  push_neg
  have halg : (algebraMap ℂ (F →L[ℂ] F)) (lam : ℂ) - A = -B := by
    rw [Algebra.algebraMap_eq_smul_one, hB]; abel
  rw [halg]
  exact hunitB.neg

omit [CompleteSpace F] in
/-- The converse: a point outside the spectrum carries a positive quantitative gap.  With
`notMem_spectrum_of_gapAt` this says that, for a bounded self-adjoint operator, `GapAt` is
exactly the statement that `λ` is at positive distance from the spectrum (self-adjointness
is not needed for this direction). -/
theorem exists_gapAt_of_notMem_spectrum {A : F →L[ℂ] F} {lam : ℝ}
    (h : (lam : ℂ) ∉ spectrum ℂ A) : ∃ d > 0, GapAt A lam d := by
  rw [spectrum.mem_iff] at h
  push_neg at h
  have halg : (algebraMap ℂ (F →L[ℂ] F)) (lam : ℂ) - A = -(A - (lam : ℂ) • (1 : F →L[ℂ] F)) := by
    rw [Algebra.algebraMap_eq_smul_one]; abel
  rw [halg] at h
  have hBunit : IsUnit (A - (lam : ℂ) • (1 : F →L[ℂ] F)) := (IsUnit.neg_iff _).mp h
  set B : F →L[ℂ] F := A - (lam : ℂ) • (1 : F →L[ℂ] F) with hBdef
  set V : F →L[ℂ] F := ↑(hBunit.unit⁻¹) with hV
  have hVB : ∀ x : F, V (B x) = x := by
    intro x
    have hmul : V * B = 1 := by
      rw [hV]
      simp
    calc V (B x) = (V * B) x := rfl
      _ = (1 : F →L[ℂ] F) x := by rw [hmul]
      _ = x := rfl
  refine ⟨1 / (‖V‖ + 1), by positivity, ?_⟩
  intro x
  have hBx : B x = A x - (lam : ℂ) • x := by simp [hBdef]
  have h1 : ‖x‖ ≤ ‖V‖ * ‖B x‖ := by
    calc ‖x‖ = ‖V (B x)‖ := by rw [hVB x]
      _ ≤ ‖V‖ * ‖B x‖ := V.le_opNorm _
  have h2 : ‖x‖ ≤ (‖V‖ + 1) * ‖B x‖ := by nlinarith [norm_nonneg (B x), norm_nonneg V]
  rw [← hBx, div_mul_eq_mul_div, one_mul, div_le_iff₀ (by positivity)]
  linarith [h2]

/-- **The gap-preserving conclusion.**  If bounded self-adjoint approximants have a
uniform quantitative gap at a real `λ` and converge to `B` in operator norm, then `λ` is
not in the spectrum of the limit. -/
theorem notMem_spectrum_of_uniform_gap {A : ℕ → F →L[ℂ] F} {B : F →L[ℂ] F}
    (hB : IsSelfAdjoint B) {lam d : ℝ} (hd : 0 < d) (hgap : ∀ m, GapAt (A m) lam d)
    (hconv : Tendsto (fun m => ‖A m - B‖) atTop (𝓝 0)) : (lam : ℂ) ∉ spectrum ℂ B :=
  notMem_spectrum_of_gapAt hB hd (gapAt_of_tendsto hgap hconv)

/-- **A spectral gap window survives the limit.**  If, for each real `λ` strictly between
`a` and `b`, the approximants have the natural quantitative gap `min (λ − a) (b − λ)` at
`λ`, and they converge in operator norm, then the limit has no spectrum in `(a, b)`. -/
theorem spectrum_disjoint_of_uniform_window {A : ℕ → F →L[ℂ] F} {B : F →L[ℂ] F}
    (hB : IsSelfAdjoint B) {a b : ℝ}
    (hgap : ∀ lam ∈ Set.Ioo a b, ∀ m, GapAt (A m) lam (min (lam - a) (b - lam)))
    (hconv : Tendsto (fun m => ‖A m - B‖) atTop (𝓝 0)) :
    ∀ lam ∈ Set.Ioo a b, (lam : ℂ) ∉ spectrum ℂ B := by
  intro lam hlam
  have hd : 0 < min (lam - a) (b - lam) := lt_min (by linarith [hlam.1]) (by linarith [hlam.2])
  exact notMem_spectrum_of_uniform_gap hB hd (hgap lam hlam) hconv

/-- A shifted-square gap witness.  If the positive observable
`(A - c)^2` dominates `q` times the identity, then `A` has no spectrum in the
open interval `(c - sqrt q, c + sqrt q)`.  This is the observable form of a
mass-gap certificate: the witness is a quadratic form, rather than a claim
about a Krylov matrix alone. -/
theorem spectrum_disjoint_of_shifted_square_bound {A : F →L[ℂ] F} (hA : IsSelfAdjoint A)
    {c q : ℝ} (hq : 0 < q)
    (hbound : ∀ x : F, q * ‖x‖ ^ 2 ≤ ‖(A - (c : ℂ) • (1 : F →L[ℂ] F)) x‖ ^ 2) :
    ∀ lam ∈ Set.Ioo (c - Real.sqrt q) (c + Real.sqrt q),
      (lam : ℂ) ∉ spectrum ℂ A := by
  intro lam hlam
  have hsqrt : 0 < Real.sqrt q := Real.sqrt_pos.2 hq
  have hdist : |lam - c| < Real.sqrt q := by
    rw [abs_lt]
    constructor <;> linarith [hlam.1, hlam.2]
  have hnot : ∀ x : F, (Real.sqrt q - |lam - c|) * ‖x‖ ≤
      ‖A x - (lam : ℂ) • x‖ := by
    intro x
    have hsq : q * ‖x‖ ^ 2 ≤ ‖A x - (c : ℂ) • x‖ ^ 2 := by
      simpa [ContinuousLinearMap.sub_apply] using hbound x
    have htri : ‖A x - (c : ℂ) • x‖ ≤
        ‖A x - (lam : ℂ) • x‖ + |lam - c| * ‖x‖ := by
      have heq : A x - (c : ℂ) • x =
          (A x - (lam : ℂ) • x) + ((lam - c : ℂ) • x) := by
        module
      rw [heq]
      calc
        ‖A x - (lam : ℂ) • x + (lam - c : ℂ) • x‖ ≤
            ‖A x - (lam : ℂ) • x‖ + ‖(lam - c : ℂ) • x‖ := norm_add_le _ _
        _ = ‖A x - (lam : ℂ) • x‖ + |lam - c| * ‖x‖ := by
          have hnorm : ‖((lam : ℂ) - (c : ℂ))‖ = |lam - c| := by
            rw [show ((lam : ℂ) - (c : ℂ)) = ((lam - c : ℝ) : ℂ) by push_cast; ring,
              Complex.norm_real, Real.norm_eq_abs]
          rw [norm_smul, hnorm]
    have hqnorm : Real.sqrt q * ‖x‖ ≤ ‖A x - (c : ℂ) • x‖ := by
      have h1 : Real.sqrt (q * ‖x‖ ^ 2) ≤ Real.sqrt (‖A x - (c : ℂ) • x‖ ^ 2) :=
        Real.sqrt_le_sqrt hsq
      rwa [Real.sqrt_mul hq.le, Real.sqrt_sq (norm_nonneg x),
        Real.sqrt_sq (norm_nonneg _)] at h1
    linarith
  have hpos : 0 < Real.sqrt q - |lam - c| := sub_pos.mpr hdist
  exact notMem_spectrum_of_gapAt hA hpos (by simpa [ContinuousLinearMap.sub_apply] using hnot)

end BookProof.SpectralGapStability
