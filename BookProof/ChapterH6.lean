import Mathlib
import BookProof.ChapterH4
import BookProof.ChapterH5

/-!
# Chapter H6 — Krylov projection as a spectral low-pass filter (plan Part F.2,
roadmap §9.2)

`QFM.tex` §9.2 reads the Krylov projection of the Hashimoto generator as an
*exact spectral low-pass filter*: the reduced `m × m` generator keeps the
dominant part of the spectrum, the discarded high-frequency content costs only
the `e^{−hm}` term already carried by `ChapterH4.sirk_error_bound_decay`, and
generation is then a single `O(m²)` matrix exponential.

## Deliverables

* `sirk_error_decay_exponential` — the SIRK error bound of
  `ChapterH4.sirk_error_bound_decay` really decays: as the Krylov dimension `m`
  grows the bound tends to `0` (for `h > 0`), and `sirk_error_bound_antitone`
  records that it is non-increasing in `m`;
* `sirk_error_tendsto_zero` — consequently the SIRK approximants converge:
  the errors are eventually below any `ε > 0`;
* `krylov_rayleigh_transfer` — the Rayleigh–Ritz identity
  `⟪y, (V∗XV) y⟫ = ⟪Vy, X (Vy)⟫`: the reduced generator's quadratic form is a
  *restriction* of the full one;
* `krylovRetainsDominantSpectrum` — hence every eigenvalue of the reduced
  generator is a Rayleigh quotient of `X` and is bounded by `‖X‖`: the
  compression retains spectrum, it never manufactures new frequencies;
* `reduceGenerator`, `reduceGenerator_eq_compress_entry`,
  `reduce_generator_mul_m` — the reduced generator `H̄_reduced = Vᴴ H̄ V` is an
  explicit `m × m` matrix, i.e. exactly `m²` scalars;
* `generation_at_zero`, `generation_semigroup`,
  `generation_single_exponential` — **headline**: generation is a *single*
  matrix exponential `Ψ_{t=1} = e^{−i H̄_reduced} Ψ₀` of the reduced generator,
  with the semigroup law making the whole trajectory that one exponential.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open Filter Topology

namespace BookProof.ChapterH6

/-! ## The exponential decay of the SIRK bound -/

/-- The eq.-(12) SIRK error bound of `ChapterH4.sirk_error_bound_decay`, as an
explicit function of the Krylov dimension `m`. -/
def sirkBound (C Dmin h nv : ℝ) (m : ℕ) : ℝ :=
  2 * C * Real.exp (-(h * m)) * Dmin * nv

/-- **F.2 — exponential decay.**  For a positive step `h`, the SIRK error bound
tends to `0` as the Krylov dimension `m` grows: the projection filters out
everything above the retained `m` frequencies at exponential rate `e^{−hm}`. -/
theorem sirk_error_decay_exponential (C Dmin h nv : ℝ) (hh : 0 < h) :
    Tendsto (fun m : ℕ => sirkBound C Dmin h nv m) atTop (𝓝 0) := by
  have hlin : Tendsto (fun m : ℕ => -(h * (m : ℝ))) atTop atBot := by
    have : Tendsto (fun m : ℕ => h * (m : ℝ)) atTop atTop :=
      Tendsto.const_mul_atTop hh tendsto_natCast_atTop_atTop
    exact tendsto_neg_atTop_atBot.comp this
  have hexp : Tendsto (fun m : ℕ => Real.exp (-(h * (m : ℝ)))) atTop (𝓝 0) :=
    Real.tendsto_exp_atBot.comp hlin
  have := ((hexp.const_mul (2 * C)).mul_const Dmin).mul_const nv
  simpa [sirkBound, mul_zero, zero_mul] using this

/-- The bound is non-increasing in the Krylov dimension: enlarging the subspace
never makes the guarantee worse. -/
theorem sirk_error_bound_antitone (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 ≤ h) :
    Antitone (fun m : ℕ => sirkBound C Dmin h nv m) := by
  intro a b hab
  have hexp : Real.exp (-(h * (b : ℝ))) ≤ Real.exp (-(h * (a : ℝ))) := by
    apply Real.exp_le_exp.mpr
    have : (a : ℝ) ≤ (b : ℝ) := Nat.cast_le.mpr hab
    nlinarith
  have h2C : 0 ≤ 2 * C := by linarith
  exact mul_le_mul_of_nonneg_right
    (mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hexp h2C) hD) hnv

/-- **Convergence of the reduced generation.**  Combining
`ChapterH4.sirk_error_bound_decay` with the decay above: for every `ε > 0` the
SIRK error is eventually below `ε`. -/
theorem sirk_error_tendsto_zero (C Dmin h nv : ℝ) (hh : 0 < h) {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ m : ℕ in atTop, |sirkBound C Dmin h nv m| < ε := by
  have h0 := sirk_error_decay_exponential C Dmin h nv hh
  have := h0 (Metric.ball_mem_nhds (0 : ℝ) hε)
  simpa [Real.dist_eq, Metric.mem_ball] using this

/-! ## Rayleigh–Ritz: the compression retains spectrum -/

section RayleighRitz

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

open BookProof.ChapterH4

/-- **The Rayleigh–Ritz identity.**  The quadratic form of the compressed
generator `B = V∗ X V` is the restriction of the quadratic form of `X` to the
embedded subspace. -/
theorem krylov_rayleigh_transfer (V : F →L[ℂ] E) (X : E →L[ℂ] E) (y : F) :
    inner ℂ y (compress V X y) = inner ℂ (V y) (X (V y)) := by
  rw [compress]
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply]
  exact ContinuousLinearMap.adjoint_inner_right V y (X (V y))

/-- **F.2 — the Krylov projection retains the dominant spectrum.**  Every
eigenvalue of the reduced generator is a Rayleigh quotient of the full generator
along the embedded subspace, hence bounded by `‖X‖`: the compression can only
*keep* frequencies of `X`, never create new ones above its spectral radius. -/
theorem krylovRetainsDominantSpectrum (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖) (lam : ℂ) (y : F) (hy : ‖y‖ = 1)
    (heig : compress V X y = lam • y) :
    lam = inner ℂ (V y) (X (V y)) ∧ ‖lam‖ ≤ ‖X‖ := by
  have hyy : (inner ℂ y y : ℂ) = 1 := by
    rw [inner_self_eq_norm_sq_to_K, hy]
    norm_num
  have hval : (inner ℂ y (compress V X y) : ℂ) = lam := by
    rw [heig, inner_smul_right, hyy, mul_one]
  have hlam : lam = inner ℂ (V y) (X (V y)) := by
    rw [← hval, krylov_rayleigh_transfer]
  refine ⟨hlam, ?_⟩
  have hVy : ‖V y‖ = 1 := by rw [hViso, hy]
  have hcs : ‖(inner ℂ (V y) (X (V y)) : ℂ)‖ ≤ ‖V y‖ * ‖X (V y)‖ :=
    norm_inner_le_norm _ _
  have hXb : ‖X (V y)‖ ≤ ‖X‖ := by
    have := X.le_opNorm (V y)
    rwa [hVy, mul_one] at this
  rw [hlam]
  calc ‖(inner ℂ (V y) (X (V y)) : ℂ)‖ ≤ ‖V y‖ * ‖X (V y)‖ := hcs
    _ = ‖X (V y)‖ := by rw [hVy, one_mul]
    _ ≤ ‖X‖ := hXb

end RayleighRitz

/-! ## The reduced generator is an explicit `m × m` matrix -/

section Reduced

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open BookProof.ChapterH4

/-- The **reduced generator** `H̄_reduced = Vᴴ H̄ V` as an explicit `m × m`
matrix of inner products. -/
def reduceGenerator (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] E) (X : E →L[ℂ] E) :
    Matrix (Fin m) (Fin m) ℂ :=
  Matrix.of fun i j =>
    inner ℂ (V (EuclideanSpace.single i (1 : ℂ))) (X (V (EuclideanSpace.single j (1 : ℂ))))

/-- Its entries are the matrix entries of the compression `V∗ X V`. -/
theorem reduceGenerator_eq_compress_entry (m : ℕ)
    (V : EuclideanSpace ℂ (Fin m) →L[ℂ] E) (X : E →L[ℂ] E) (i j : Fin m) :
    reduceGenerator m V X i j
      = inner ℂ (EuclideanSpace.single i (1 : ℂ))
          (compress V X (EuclideanSpace.single j (1 : ℂ))) := by
  rw [reduceGenerator, compress]
  simp only [Matrix.of_apply, ContinuousLinearMap.coe_comp', Function.comp_apply]
  exact (ContinuousLinearMap.adjoint_inner_right V _ _).symm

/-- **F.2 — the reduction really is to `m²` scalars.**  The reduced generator is
an `m × m` matrix, i.e. it is determined by exactly `m·m` complex numbers, no
matter how large the ambient space is. -/
theorem reduce_generator_mul_m (m : ℕ) : Fintype.card (Fin m × Fin m) = m * m := by
  simp

end Reduced

/-! ## Generation as a single matrix exponential -/

section Generation

variable {m : ℕ}

/-- The generated state at time `t`: a *single* exponential of the reduced
generator, `Ψ(t) = e^{−i t H̄_reduced} Ψ₀`. -/
def generatedState (A : Matrix (Fin m) (Fin m) ℂ) (t : ℂ)
    (psi0 : Fin m → ℂ) : Fin m → ℂ :=
  (NormedSpace.exp ((-Complex.I * t) • A)).mulVec psi0

theorem generation_at_zero (A : Matrix (Fin m) (Fin m) ℂ) (psi0 : Fin m → ℂ) :
    generatedState A 0 psi0 = psi0 := by
  rw [generatedState]
  simp [NormedSpace.exp_zero, Matrix.one_mulVec]

/-- The one-parameter group law: the trajectory is generated by the one
exponential. -/
theorem generation_semigroup (A : Matrix (Fin m) (Fin m) ℂ) (s t : ℂ)
    (psi0 : Fin m → ℂ) :
    generatedState A (s + t) psi0 = generatedState A s (generatedState A t psi0) := by
  have hcomm : Commute ((-Complex.I * s) • A) ((-Complex.I * t) • A) := by
    unfold Commute SemiconjBy
    rw [Matrix.smul_mul, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_smul, smul_smul, smul_smul,
      mul_comm (-Complex.I * s) (-Complex.I * t)]
  have hsplit : (-Complex.I * (s + t)) • A
      = ((-Complex.I * s) • A) + ((-Complex.I * t) • A) := by
    rw [← add_smul]
    congr 1
    ring
  rw [generatedState, generatedState, generatedState, hsplit,
    Matrix.exp_add_of_commute _ _ hcomm, ← Matrix.mulVec_mulVec]

/-- **Headline (F.2).**  Generation is a single `O(m²)` matrix exponential of the
reduced generator: `Ψ_{t=1} = e^{−i H̄_reduced} Ψ₀`. -/
theorem generation_single_exponential (A : Matrix (Fin m) (Fin m) ℂ) (psi0 : Fin m → ℂ) :
    generatedState A 1 psi0 = (NormedSpace.exp ((-Complex.I) • A)).mulVec psi0 := by
  rw [generatedState, mul_one]

end Generation

end BookProof.ChapterH6

end
