import Mathlib


/-!
# Note 68, the angular half: the generator of rotations and the eigenvalue `μ`

Source: `book.tex`, §A.5, subsection *"Hankel–Majorana Transform"*, **Note 68**
(`book.tex` line ~5860).  Besides the Laplacian identity (the radial half, proved
in `BookProof.ChapterSphericalBesselODE` and `BookProof.ChapterRadialLaplacian`),
Note 68 states that the inverse spherical transform intertwines the third
component of the angular momentum with multiplication by `μ`:

`(−x¹ i ∂₂ + x² i ∂₁) 𝓗_P⁻¹{ψ}(x⃗) = 𝓗_P⁻¹{R'ψ}(x⃗)`,  `R'ψ(p,l,μ) = μ ψ(p,l,μ)`.

The self-contained mathematical content is that the differential operator
`L₃ = −i(x¹∂₂ − x²∂₁)` — the generator of rotations in the `1`–`2` plane —
has eigenvalue `μ` exactly on the functions that transform with the phase
`e^{iμt}` under those rotations, which is precisely the `e^{iμφ}` factor of the
spherical harmonic `Y_{lμ}`.  The plane of the rotation is identified with `ℂ`,
so that the rotation by the angle `t` is multiplication by `e^{it}` and the
generating vector field at `z` is `i z`.

## Contents

* `fderiv_rotationVector` — the rotation vector field in Cartesian form:
  `Du(z)(i z) = x¹ ∂₂u(z) − x² ∂₁u(z)` (pure `ℝ`-linearity);
* `angularMomentum_eigen` — **the eigenvalue statement**: if `u` is real
  differentiable at `z` and `u(e^{it} z) = e^{iμt} u(z)` for every `t`, then
  `−i (x¹ ∂₂u(z) − x² ∂₁u(z)) = μ u(z)`;
* `circHarm` — the circular harmonic `(z/‖z‖)^μ`, the `e^{iμφ}` factor of
  `Y_{lμ}`; `circHarm_rotate` is its equivariance and
  `circHarm_angularMomentum_eigen` the resulting eigenvalue equation, so the
  hypothesis of `angularMomentum_eigen` is not vacuous;
* `circHarm_abs` — the circular harmonic has modulus one away from the origin.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterAngularMomentum

open Complex





/-! ## The circular harmonic `e^{iμφ} = (z/‖z‖)^μ` -/

/-- The circular harmonic of order `μ`: the `e^{iμφ}` factor of the spherical
harmonic `Y_{lμ}`, written as `(z/‖z‖)^μ` in the plane of the rotation. -/
noncomputable def circHarm (μ : ℕ) (z : ℂ) : ℂ := (z / (‖z‖ : ℂ)) ^ μ





–Majorana Transform"*, **Note 68**
(`book.tex` line ~5860).  Besides the Laplacian identity (the radial half, proved
in `BookProof.ChapterSphericalBesselODE` and `BookProof.ChapterRadialLaplacian`),
Note 68 states that the inverse spherical transform intertwines the third
component of the angular momentum with multiplication by `μ`:

`(−x¹ i ∂₂ + x² i ∂₁) 𝓗_P⁻¹{ψ}(x⃗) = 𝓗_P⁻¹{R'ψ}(x⃗)`,  `R'ψ(p,l,μ) = μ ψ(p,l,μ)`.

The self-contained mathematical content is that the differential operator
`L₃ = −i(x¹∂₂ − x²∂₁)` — the generator of rotations in the `1`–`2` plane —
has eigenvalue `μ` exactly on the functions that transform with the phase
`e^{iμt}` under those rotations, which is precisely the `e^{iμφ}` factor of the
spherical harmonic `Y_{lμ}`.  The plane of the rotation is identified with `ℂ`,
so that the rotation by the angle `t` is multiplication by `e^{it}` and the
generating vector field at `z` is `i z`.

## Contents

* `fderiv_rotationVector` — the rotation vector field in Cartesian form:
  `Du(z)(i z) = x¹ ∂₂u(z) − x² ∂₁u(z)` (pure `ℝ`-linearity);
* `angularMomentum_eigen` — **the eigenvalue statement**: if `u` is real
  differentiable at `z` and `u(e^{it} z) = e^{iμt} u(z)` for every `t`, then
  `−i (x¹ ∂₂u(z) − x² ∂₁u(z)) = μ u(z)`;
* `circHarm` — the circular harmonic `(z/‖z‖)^μ`, the `e^{iμφ}` factor of
  `Y_{lμ}`; `circHarm_rotate` is its equivariance and
  `circHarm_angularMomentum_eigen` the resulting eigenvalue equation, so the
  hypothesis of `angularMomentum_eigen` is not vacuous;
* `circHarm_abs` — the circular harmonic has modulus one away from the origin.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterAngularMomentum

open Complex

/-- The generating vector field of the rotations of the plane, in Cartesian
form: `D u(z)(i z) = x¹ ∂₂u(z) − x² ∂₁u(z)`. -/
theorem fderiv_rotationVector (u : ℂ → ℂ) (z : ℂ) :
    fderiv ℝ u z (Complex.I * z)
      = z.re * fderiv ℝ u z Complex.I - z.im * fderiv ℝ u z 1 := by
  have hz : Complex.I * z = z.re • Complex.I + (-z.im) • (1 : ℂ) := by
    apply Complex.ext <;> simp
  rw [hz, map_add, map_smul, map_smul]
  simp [sub_eq_add_neg]

/-- **Note 68, the angular half.**  If `u` transforms under the rotations of the
`1`–`2` plane with the phase `e^{iμt}`, then it is an eigenfunction of the
angular momentum operator `L₃ = −i(x¹∂₂ − x²∂₁)` with eigenvalue `μ`. -/
theorem angularMomentum_eigen {u : ℂ → ℂ} {μ : ℝ} {z : ℂ}
    (hdiff : DifferentiableAt ℝ u z)
    (hequiv : ∀ t : ℝ, u (Complex.exp ((t : ℂ) * Complex.I) * z)
      = Complex.exp ((μ : ℂ) * (t : ℂ) * Complex.I) * u z) :
    -Complex.I * (z.re * fderiv ℝ u z Complex.I - z.im * fderiv ℝ u z 1) = (μ : ℂ) * u z := by
  -- the rotation path and its velocity at `t = 0`
  have hpath : HasDerivAt (fun s : ℝ => Complex.exp ((s : ℂ) * Complex.I) * z)
      (Complex.I * z) 0 := by
    have h : HasDerivAt (fun s : ℝ => ((s : ℂ) * Complex.I)) Complex.I (0 : ℝ) := by
      simpa using (Complex.ofRealCLM.hasDerivAt (x := (0 : ℝ))).mul_const Complex.I
    have hexp : HasDerivAt (fun s : ℝ => Complex.exp ((s : ℂ) * Complex.I))
        (Complex.exp (((0 : ℝ) : ℂ) * Complex.I) * Complex.I) 0 := h.cexp
    simpa using hexp.mul_const z
  -- the derivative of `t ↦ u(e^{it} z)` at `0`, computed by the chain rule
  have hchain : HasDerivAt (fun s : ℝ => u (Complex.exp ((s : ℂ) * Complex.I) * z))
      (fderiv ℝ u z (Complex.I * z)) 0 := by
    have hu : HasFDerivAt u (fderiv ℝ u z)
        ((fun s : ℝ => Complex.exp ((s : ℂ) * Complex.I) * z) 0) := by
      simpa using hdiff.hasFDerivAt
    have h := HasFDerivAt.comp_hasDerivAt (0 : ℝ) hu hpath
    exact h
  -- the same derivative, computed from the equivariance
  have hphase : HasDerivAt (fun s : ℝ => Complex.exp ((μ : ℂ) * (s : ℂ) * Complex.I) * u z)
      (Complex.I * (μ : ℂ) * u z) 0 := by
    have h : HasDerivAt (fun s : ℝ => (μ : ℂ) * (s : ℂ) * Complex.I)
        ((μ : ℂ) * Complex.I) (0 : ℝ) := by
      have h0 : HasDerivAt (fun s : ℝ => ((s : ℂ))) 1 (0 : ℝ) :=
        Complex.ofRealCLM.hasDerivAt (x := (0 : ℝ))
      simpa [mul_comm, mul_assoc] using ((h0.const_mul (μ : ℂ)).mul_const Complex.I)
    have hexp := h.cexp
    have := hexp.mul_const (u z)
    simpa [mul_comm, mul_assoc, mul_left_comm] using this
  have hfun : (fun s : ℝ => u (Complex.exp ((s : ℂ) * Complex.I) * z))
      = fun s : ℝ => Complex.exp ((μ : ℂ) * (s : ℂ) * Complex.I) * u z := by
    funext s; exact hequiv s
  rw [hfun] at hchain
  have hval : fderiv ℝ u z (Complex.I * z) = Complex.I * (μ : ℂ) * u z :=
    hchain.unique hphase
  rw [← fderiv_rotationVector u z, hval]
  have : -Complex.I * (Complex.I * (μ : ℂ) * u z) = (μ : ℂ) * u z := by
    rw [show -Complex.I * (Complex.I * (μ : ℂ) * u z)
      = (-(Complex.I * Complex.I)) * ((μ : ℂ) * u z) by ring, Complex.I_mul_I]
    ring
  exact this

/-! ## The circular harmonic `e^{iμφ} = (z/‖z‖)^μ` -/

/-- The circular harmonic of order `μ`: the `e^{iμφ}` factor of the spherical
harmonic `Y_{lμ}`, written as `(z/‖z‖)^μ` in the plane of the rotation. -/
noncomputable def circHarm (μ : ℕ) (z : ℂ) : ℂ := (z / (‖z‖ : ℂ)) ^ μ

theorem circHarm_abs {μ : ℕ} {z : ℂ} (hz : z ≠ 0) : ‖circHarm μ z‖ = 1 := by
  have hnz : ‖z‖ ≠ 0 := norm_ne_zero_iff.mpr hz
  rw [circHarm, norm_pow, norm_div]
  simp [hnz]

/-- Equivariance: rotating by the angle `t` multiplies the circular harmonic by
the phase `e^{iμt}`. -/
theorem circHarm_rotate (μ : ℕ) (t : ℝ) (z : ℂ) :
    circHarm μ (Complex.exp ((t : ℂ) * Complex.I) * z)
      = Complex.exp ((μ : ℂ) * (t : ℂ) * Complex.I) * circHarm μ z := by
  have hnorm : ‖Complex.exp ((t : ℂ) * Complex.I) * z‖ = ‖z‖ := by
    rw [norm_mul, Complex.norm_exp]
    simp
  rw [circHarm, circHarm, hnorm, mul_div_assoc, mul_pow, ← Complex.exp_nat_mul]
  ring_nf

/-- The circular harmonic is differentiable away from the origin. -/
theorem circHarm_differentiableAt {μ : ℕ} {z : ℂ} (hz : z ≠ 0) :
    DifferentiableAt ℝ (circHarm μ) z := by
  have hn : DifferentiableAt ℝ (fun w : ℂ => ‖w‖) z :=
    (contDiffAt_norm (n := 1) ℝ hz).differentiableAt (by norm_num)
  have hnorm : DifferentiableAt ℝ (fun w : ℂ => ((‖w‖ : ℝ) : ℂ)) z :=
    Complex.ofRealCLM.differentiableAt.comp z hn
  have hne : (fun w : ℂ => ((‖w‖ : ℝ) : ℂ)) z ≠ 0 := by
    simpa using (norm_ne_zero_iff.mpr hz)
  have hinv : DifferentiableAt ℝ (fun w : ℂ => (((‖w‖ : ℝ) : ℂ))⁻¹) z := hnorm.inv hne
  have hmul : DifferentiableAt ℝ (fun w : ℂ => w * (((‖w‖ : ℝ) : ℂ))⁻¹) z :=
    differentiableAt_id.mul hinv
  have hfun : circHarm μ = fun w : ℂ => (w * (((‖w‖ : ℝ) : ℂ))⁻¹) ^ μ := by
    funext w; rw [circHarm, div_eq_mul_inv]
  rw [hfun]
  exact hmul.pow μ

/-- **The circular harmonic is an eigenfunction of `L₃` with eigenvalue `μ`.**
This is the hypothesis of `angularMomentum_eigen` realized concretely, so the
eigenvalue statement is not vacuous. -/
theorem circHarm_angularMomentum_eigen (μ : ℕ) {z : ℂ} (hz : z ≠ 0) :
    -Complex.I * (z.re * fderiv ℝ (circHarm μ) z Complex.I
        - z.im * fderiv ℝ (circHarm μ) z 1)
      = (μ : ℂ) * circHarm μ z :=
  angularMomentum_eigen (μ := (μ : ℝ)) (circHarm_differentiableAt hz)
    (by intro t; simpa using circHarm_rotate μ t z)

end BookProof.ChapterAngularMomentum
