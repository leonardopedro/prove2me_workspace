import Mathlib
import BookProof.ChapterRitzCertificate

/-!
# Chapter TempleSeparationNecessary — the spectral-separation input cannot be removed

`ChapterRitzCertificate` derives the per-order finite certificate from Temple's inequality,
whose one non-computational input is the spectral separation

  `SpectralSeparation A l b`  —  `l ≤ b` and every spectral point is `l` or `≥ b`.

`CONSOLIDATED_PLAN.md` records this as the remaining side condition of the certificate
route.  This chapter shows that it is a *genuine* side condition and not an artifact of the
proof: **no** bound on the spectral edge in terms of the Rayleigh quotient and residual of a
trial vector can hold without it.

`separation_necessary` exhibits, for every `M`, a bounded self-adjoint operator on a
two-dimensional Hilbert space and a unit trial vector whose Rayleigh quotient and residual
are both `0` — the best possible finite data — while the bottom of the spectrum is at most
`−M`.  So the residual alone controls nothing: a trial vector can be an *exact* eigenvector
and still say nothing about how far below the spectrum extends.  Some a priori information
about the rest of the spectrum, which is exactly what `SpectralSeparation` supplies, must be
provided from outside the finite computation.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.TempleSeparationNecessary

open BookProof.RitzCertificate

/-- The two-dimensional witness space. -/
abbrev E2 := EuclideanSpace ℂ (Fin 2)

/-- The rank-one orthogonal projection onto `ℂ ∙ x`, for a unit vector `x`. -/
def proj (x : E2) : E2 →L[ℂ] E2 := (innerSL ℂ x).smulRight x

@[simp] theorem proj_apply (x y : E2) : proj x y = (inner ℂ x y : ℂ) • x := rfl

/-- The witness operator: `−M` on the orthogonal complement of `x`, and `0` on `ℂ ∙ x`. -/
def witness (M : ℝ) (x : E2) : E2 →L[ℂ] E2 :=
  ((-M : ℝ) : ℂ) • ((1 : E2 →L[ℂ] E2) - proj x)

theorem witness_apply (M : ℝ) (x y : E2) :
    witness M x y = ((-M : ℝ) : ℂ) • (y - (inner ℂ x y : ℂ) • x) := rfl

theorem isSelfAdjoint_witness (M : ℝ) (x : E2) : IsSelfAdjoint (witness M x) := by
  rw [ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric]
  intro u v
  simp only [ContinuousLinearMap.coe_coe, witness_apply, inner_smul_left, inner_smul_right,
    inner_sub_left, inner_sub_right, Complex.conj_ofReal]
  rw [inner_conj_symm]
  ring

/-- The trial vector: the first basis vector, an exact eigenvector of `witness M x` for the
eigenvalue `0`. -/
def trial : E2 := EuclideanSpace.single 0 (1 : ℂ)

/-- The vector orthogonal to the trial vector, an exact eigenvector for `−M`. -/
def other : E2 := EuclideanSpace.single 1 (1 : ℂ)

theorem norm_trial : ‖trial‖ = 1 := by simp [trial]

theorem other_ne_zero : other ≠ 0 := by
  intro h
  have := congrArg (fun v : E2 => v 1) h
  simp [other, EuclideanSpace.single_apply] at this

theorem inner_trial_other : (inner ℂ trial other : ℂ) = 0 := by
  simp [trial, other, EuclideanSpace.inner_single_left, EuclideanSpace.single_apply]

theorem witness_trial (M : ℝ) : witness M trial trial = 0 := by
  have h : (inner ℂ trial trial : ℂ) = 1 := by
    rw [inner_self_eq_norm_sq_to_K, norm_trial]; norm_num
  rw [witness_apply, h, one_smul, sub_self, smul_zero]

theorem witness_other (M : ℝ) : witness M trial other = ((-M : ℝ) : ℂ) • other := by
  rw [witness_apply, inner_trial_other, zero_smul, sub_zero]

/-! ## The finite data are perfect, and say nothing -/

theorem rayleigh_witness (M : ℝ) : rayleigh (witness M trial) trial = 0 := by
  rw [rayleigh, witness_trial, inner_zero_right, Complex.zero_re]

theorem resid_witness (M : ℝ) : resid (witness M trial) trial = 0 := by
  rw [resid, rayleigh_witness, witness_trial]
  norm_num

/-! ## Yet the spectrum reaches down to `−M` -/

theorem neg_mem_spectrum_witness (M : ℝ) : (-M) ∈ spectrum ℝ (witness M trial) := by
  intro hunit
  have hzero : (algebraMap ℝ (E2 →L[ℂ] E2) (-M) - witness M trial) other = 0 := by
    have halg : algebraMap ℝ (E2 →L[ℂ] E2) (-M) = ((-M : ℝ) : ℂ) • (1 : E2 →L[ℂ] E2) := by
      ext y
      simp [Algebra.algebraMap_eq_smul_one]
    rw [halg]
    simp only [ContinuousLinearMap.sub_apply, ContinuousLinearMap.smul_apply,
      ContinuousLinearMap.one_apply, witness_other]
    exact sub_self _
  obtain ⟨u, hu⟩ := hunit
  have hmul : ((↑u⁻¹ : E2 →L[ℂ] E2) *
      (algebraMap ℝ (E2 →L[ℂ] E2) (-M) - witness M trial)) other = other := by
    rw [← hu, u.inv_mul, ContinuousLinearMap.one_apply]
  rw [ContinuousLinearMap.mul_apply, hzero, map_zero] at hmul
  exact other_ne_zero hmul.symm

theorem bddBelow_spectrum (A : E2 →L[ℂ] E2) : BddBelow (spectrum ℝ A) := by
  refine ⟨-‖A‖, fun t ht => ?_⟩
  have h := spectrum.norm_le_norm_of_mem ht
  have : |t| ≤ ‖A‖ := by simpa [Real.norm_eq_abs] using h
  cases abs_le.mp this with
  | intro h1 _ => exact h1

/-- **The spectral-separation hypothesis of Temple's inequality is necessary.**  For every
`M` there is a bounded self-adjoint operator on a two-dimensional Hilbert space and a unit
trial vector whose Rayleigh quotient and residual both vanish — the trial vector is an exact
eigenvector, the best finite data possible — while the bottom of the spectrum is at most
`−M`.

Hence no lower bound on `sInf (spectrum ℝ A)` in terms of `rayleigh A x` and `resid A x`
alone can be valid: the a priori information encoded by
`RitzCertificate.SpectralSeparation` cannot be dispensed with. -/
theorem separation_necessary (M : ℝ) :
    ∃ (A : E2 →L[ℂ] E2) (x : E2), IsSelfAdjoint A ∧ ‖x‖ = 1 ∧
      rayleigh A x = 0 ∧ resid A x = 0 ∧ sInf (spectrum ℝ A) ≤ -M :=
  ⟨witness M trial, trial, isSelfAdjoint_witness M trial, norm_trial,
    rayleigh_witness M, resid_witness M,
    csInf_le (bddBelow_spectrum _) (neg_mem_spectrum_witness M)⟩

end BookProof.TempleSeparationNecessary

end
