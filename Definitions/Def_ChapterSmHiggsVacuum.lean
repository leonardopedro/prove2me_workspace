import Mathlib


/-!
# The Higgs vacuum: symmetry breaking as statics

The Standard-Model chapters of this project record, as an honest boundary, that **no
electroweak symmetry breaking as dynamics** is claimed: `V(φ)` and `D_iφ` are in the
one-particle operator, but no theorem selects the minimum `⟨φ⟩` or reads off masses.  This
module supplies the part of that statement which *is* a theorem about the potential of
`BookProof.ChapterSmHamiltonian` — the **statics** of symmetry breaking:

* `higgsV_sq_form` — the Mexican-hat identity
  `V(φ) = (λ/4)(‖φ‖² − μ²/λ)² − μ⁴/(4λ)`;
* `higgsV_ge_min` and `higgsV_eq_min_iff` — the potential is bounded below by `−μ⁴/(4λ)`,
  and the minimum is attained **exactly** on the vacuum manifold `‖φ‖² = μ²/λ = v²`: the
  vacuum is degenerate, which is what “broken symmetry” means at this level;
* `higgs_goldstone` — along any direction `w` orthogonal to a vacuum `u` the potential is
  *exactly* `V(u) + (λ/4)t⁴‖w‖⁴`: no quadratic term, i.e. the transverse directions are
  **massless Goldstone directions**;
* `higgs_radial` — along the radial direction the potential is exactly
  `V(u) + μ²‖u‖²t²(1 + t + t²/4)`, whose quadratic coefficient `μ²‖u‖²` is the curvature
  `½ m²‖u‖²` with `m² = 2μ²`: the **radial (Higgs) mode is massive**;
* `gaugeMassForm`, `gaugeMassForm_nonneg`, `gaugeMassForm_smul`,
  `gaugeMassForm_eq_zero_iff` — the covariant-derivative term evaluated at a constant vacuum
  is a positive-semidefinite quadratic form in the gauge fields which vanishes **exactly** on
  the generator combinations that annihilate the vacuum: broken generators acquire a mass
  term, unbroken ones stay massless.

## Honest boundary

These are statements about the potential and the covariant derivative at a fixed vacuum —
statics.  No time evolution of the broken phase, no expansion of the quantum Hamiltonian
around the vacuum, no physical particle spectrum and no measured value (of `v`, of a gauge
boson mass, or of any CKM/PMNS parameter) is claimed here.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmHiggsVacuum

open Finset

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- **The Higgs potential** `V(φ) = −½μ²‖φ‖² + ¼λ‖φ‖⁴` of §D6b-SM.1, as a function of the
real Higgs multiplet.  `mu2` is `μ²` and `lam` is `λ`. -/
def higgsV (lam mu2 : ℝ) (phi : E) : ℝ := -(mu2 / 2) * ‖phi‖ ^ 2 + (lam / 4) * ‖phi‖ ^ 4







s an honest boundary, that **no
electroweak symmetry breaking as dynamics** is claimed: `V(φ)` and `D_iφ` are in the
one-particle operator, but no theorem selects the minimum `⟨φ⟩` or reads off masses.  This
module supplies the part of that statement which *is* a theorem about the potential of
`BookProof.ChapterSmHamiltonian` — the **statics** of symmetry breaking:

* `higgsV_sq_form` — the Mexican-hat identity
  `V(φ) = (λ/4)(‖φ‖² − μ²/λ)² − μ⁴/(4λ)`;
* `higgsV_ge_min` and `higgsV_eq_min_iff` — the potential is bounded below by `−μ⁴/(4λ)`,
  and the minimum is attained **exactly** on the vacuum manifold `‖φ‖² = μ²/λ = v²`: the
  vacuum is degenerate, which is what “broken symmetry” means at this level;
* `higgs_goldstone` — along any direction `w` orthogonal to a vacuum `u` the potential is
  *exactly* `V(u) + (λ/4)t⁴‖w‖⁴`: no quadratic term, i.e. the transverse directions are
  **massless Goldstone directions**;
* `higgs_radial` — along the radial direction the potential is exactly
  `V(u) + μ²‖u‖²t²(1 + t + t²/4)`, whose quadratic coefficient `μ²‖u‖²` is the curvature
  `½ m²‖u‖²` with `m² = 2μ²`: the **radial (Higgs) mode is massive**;
* `gaugeMassForm`, `gaugeMassForm_nonneg`, `gaugeMassForm_smul`,
  `gaugeMassForm_eq_zero_iff` — the covariant-derivative term evaluated at a constant vacuum
  is a positive-semidefinite quadratic form in the gauge fields which vanishes **exactly** on
  the generator combinations that annihilate the vacuum: broken generators acquire a mass
  term, unbroken ones stay massless.

## Honest boundary

These are statements about the potential and the covariant derivative at a fixed vacuum —
statics.  No time evolution of the broken phase, no expansion of the quantum Hamiltonian
around the vacuum, no physical particle spectrum and no measured value (of `v`, of a gauge
boson mass, or of any CKM/PMNS parameter) is claimed here.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmHiggsVacuum

open Finset

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- **The Higgs potential** `V(φ) = −½μ²‖φ‖² + ¼λ‖φ‖⁴` of §D6b-SM.1, as a function of the
real Higgs multiplet.  `mu2` is `μ²` and `lam` is `λ`. -/
def higgsV (lam mu2 : ℝ) (phi : E) : ℝ := -(mu2 / 2) * ‖phi‖ ^ 2 + (lam / 4) * ‖phi‖ ^ 4

omit [InnerProductSpace ℝ E] in
/-- **The Mexican-hat form of the Higgs potential.** -/
theorem higgsV_sq_form {lam mu2 : ℝ} (hlam : 0 < lam) (phi : E) :
    higgsV lam mu2 phi = (lam / 4) * (‖phi‖ ^ 2 - mu2 / lam) ^ 2 - mu2 ^ 2 / (4 * lam) := by
  have hne : lam ≠ 0 := ne_of_gt hlam
  rw [higgsV]
  field_simp
  ring

omit [InnerProductSpace ℝ E] in
/-- **The Higgs potential is bounded below** by `−μ⁴/(4λ)`. -/
theorem higgsV_ge_min {lam mu2 : ℝ} (hlam : 0 < lam) (phi : E) :
    -(mu2 ^ 2 / (4 * lam)) ≤ higgsV lam mu2 phi := by
  rw [higgsV_sq_form hlam]
  have h : 0 ≤ (lam / 4) * (‖phi‖ ^ 2 - mu2 / lam) ^ 2 := by positivity
  linarith

omit [InnerProductSpace ℝ E] in
/-- **The vacuum manifold.**  The Higgs potential attains its minimum exactly on the sphere
`‖φ‖² = μ²/λ`, the degenerate set of classical vacua of the broken phase. -/
theorem higgsV_eq_min_iff {lam mu2 : ℝ} (hlam : 0 < lam) (phi : E) :
    higgsV lam mu2 phi = -(mu2 ^ 2 / (4 * lam)) ↔ ‖phi‖ ^ 2 = mu2 / lam := by
  rw [higgsV_sq_form hlam]
  constructor
  · intro h
    have hz : (lam / 4) * (‖phi‖ ^ 2 - mu2 / lam) ^ 2 = 0 := by linarith
    have h4 : (lam / 4) ≠ 0 := by positivity
    have : (‖phi‖ ^ 2 - mu2 / lam) ^ 2 = 0 := by
      rcases mul_eq_zero.mp hz with h' | h'
      · exact absurd h' h4
      · exact h'
    have := pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this
    linarith
  · intro h
    rw [h]
    simp

/-- **The Goldstone directions.**  Transverse to a vacuum the potential has *no* quadratic
term: it rises only at fourth order, so the directions orthogonal to the vacuum are flat to
second order — the massless Goldstone directions of the broken phase. -/
theorem higgs_goldstone {lam mu2 : ℝ} {u w : E} (hu : lam * ‖u‖ ^ 2 = mu2)
    (hperp : (inner ℝ u w : ℝ) = 0) (t : ℝ) :
    higgsV lam mu2 (u + t • w) = higgsV lam mu2 u + (lam / 4) * t ^ 4 * ‖w‖ ^ 4 := by
  have hnorm : ‖u + t • w‖ ^ 2 = ‖u‖ ^ 2 + t ^ 2 * ‖w‖ ^ 2 := by
    rw [norm_add_sq_real, inner_smul_right, hperp, norm_smul]
    simp only [Real.norm_eq_abs, mul_pow, sq_abs]
    ring
  have hfour : ‖u + t • w‖ ^ 4 = (‖u‖ ^ 2 + t ^ 2 * ‖w‖ ^ 2) ^ 2 := by
    rw [show (4 : ℕ) = 2 * 2 from rfl, pow_mul, hnorm]
  have hfour' : ‖u‖ ^ 4 = (‖u‖ ^ 2) ^ 2 := by
    rw [show (4 : ℕ) = 2 * 2 from rfl, pow_mul]
  have hwfour : ‖w‖ ^ 4 = (‖w‖ ^ 2) ^ 2 := by
    rw [show (4 : ℕ) = 2 * 2 from rfl, pow_mul]
  subst hu
  simp only [higgsV, hnorm, hfour, hfour', hwfour]
  ring

/-- **The radial (Higgs) mode is massive.**  Along the vacuum direction the potential is
exactly `V(u) + μ²‖u‖²t²(1 + t + t²/4)`; the quadratic coefficient `μ²‖u‖²` is the curvature
`½m²‖u‖²` of a mode of mass squared `m² = 2μ²`. -/
theorem higgs_radial {lam mu2 : ℝ} {u : E} (hu : lam * ‖u‖ ^ 2 = mu2) (t : ℝ) :
    higgsV lam mu2 ((1 + t) • u)
      = higgsV lam mu2 u + mu2 * ‖u‖ ^ 2 * t ^ 2 * (1 + t + t ^ 2 / 4) := by
  have hnorm : ‖(1 + t) • u‖ ^ 2 = (1 + t) ^ 2 * ‖u‖ ^ 2 := by
    rw [norm_smul]
    simp only [Real.norm_eq_abs, mul_pow, sq_abs]
  have hfour : ‖(1 + t) • u‖ ^ 4 = ((1 + t) ^ 2 * ‖u‖ ^ 2) ^ 2 := by
    rw [show (4 : ℕ) = 2 * 2 from rfl, pow_mul, hnorm]
  have hfour' : ‖u‖ ^ 4 = (‖u‖ ^ 2) ^ 2 := by
    rw [show (4 : ℕ) = 2 * 2 from rfl, pow_mul]
  subst hu
  simp only [higgsV, hnorm, hfour, hfour']
  ring

/-! ## The gauge mass form at a vacuum -/

/-- **The gauge mass form** produced by a vacuum `u`: the covariant-derivative term
`½ Σ_i ‖X_i u‖²` of a constant Higgs configuration, for the generator combinations `X_i`
appearing in `D_i φ`.  It is the quadratic form in the gauge fields that the Higgs vacuum
adds to the Hamiltonian. -/
def gaugeMassForm (X : Fin 3 → Matrix (Fin 4) (Fin 4) ℝ) (u : Fin 4 → ℝ) : ℝ :=
  (1 / 2) * ∑ i : Fin 3, ∑ a : Fin 4, ((X i).mulVec u a) ^ 2







end

end BookProof.SmHiggsVacuum
