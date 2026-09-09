import Mathlib
import BookProof.ChapterFockWeightedSchurEsa

/-!
# From a graded band matrix to the weighted Schur gates

`BookProof.ChapterFockWeightedSchurEsa` proves essential self-adjointness of `dΓ(A)` on the
finite-occupation core under three gates weighted by a symbol `w ≥ 1` — the row gate, the
column gate and the commutator gate.  This chapter discharges all three from a single
structural hypothesis, the one satisfied by the Hermite matrix of a quadratic Hamiltonian:

```text
(card)  every column has at most `M` nonzero entries;
(band)  `A_{kj} = 0` unless `|deg j − deg k| ≤ D`;
(growth)`|A_{kj}| ≤ C (deg k + 1)`.
```

With the symbol `w k = deg k + 1` (`degW`):

* **`wRow_of_gradedBand`** — the row gate with `K = C·M`;
* **`wCol_of_gradedBand`** — the column gate with the same `K`, by hermiticity;
* **`wComm_of_gradedBand`** — the commutator gate with `B = C·M·D·(D+2)`: the band makes
  `|w_j² − w_k²| / (w_k w_j) ≤ D(D+2)/w_k`, which cancels the growth of the entries;
* **`dGamma_essentiallySelfAdjointOn_core_gradedBand`** — hence `dΓ(A)` is essentially
  self-adjoint on the finite-occupation core.  The one-particle operator need not be
  bounded: only its growth relative to the grading is constrained.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.GradedBandSchur

open BookProof.FockSecondQuantization BookProof.FockSchur BookProof.FockWeightedSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {deg : ℕ → ℕ} {D M : ℕ} {C : ℝ}

/-- The symbol attached to a grading: `w k = deg k + 1`. -/
def degW (deg : ℕ → ℕ) : ℕ → ℝ := fun k => (deg k : ℝ) + 1

theorem degW_ge_one (deg : ℕ → ℕ) (k : ℕ) : 1 ≤ degW deg k := by
  simp only [degW]
  have : (0:ℝ) ≤ (deg k : ℝ) := Nat.cast_nonneg _
  linarith

theorem degW_pos (deg : ℕ → ℕ) (k : ℕ) : 0 < degW deg k :=
  lt_of_lt_of_le zero_lt_one (degW_ge_one deg k)

/-- The **row gate** of a graded band matrix. -/
theorem wRow_of_gradedBand (hC : 0 ≤ C)
    (hcard : ∀ k, (col k).support.card ≤ M)
    (hent : ∀ k j, ‖(col k) j‖ ≤ C * ((deg k : ℝ) + 1)) :
    WRowBound (degW deg) col (C * M) := by
  intro k
  calc ∑ j ∈ (col k).support, ‖(col k) j‖
      ≤ (col k).support.card • (C * ((deg k : ℝ) + 1)) :=
        Finset.sum_le_card_nsmul _ _ _ fun j _ => hent k j
    _ = (col k).support.card * (C * ((deg k : ℝ) + 1)) := by rw [nsmul_eq_mul]
    _ ≤ M * (C * ((deg k : ℝ) + 1)) := by
        refine mul_le_mul_of_nonneg_right (by exact_mod_cast hcard k) ?_
        have : (0:ℝ) ≤ (deg k : ℝ) + 1 := by positivity
        exact mul_nonneg hC this
    _ = C * M * degW deg k := by simp only [degW]; ring

/-- The **column gate** of a graded band matrix. -/
theorem wCol_of_gradedBand (hC : 0 ≤ C) (hherm : IsHermCol col)
    (hcard : ∀ k, (col k).support.card ≤ M)
    (hent : ∀ k j, ‖(col k) j‖ ≤ C * ((deg k : ℝ) + 1)) :
    WColBound (degW deg) col (C * M) := by
  intro j
  have hterm : ∀ k ∈ (col j).support, ‖(col j) k‖ / degW deg k ≤ C := by
    intro k _
    have hsym : ‖(col j) k‖ = ‖(col k) j‖ := by rw [hherm j k]; simp
    have hk : ‖(col k) j‖ ≤ C * degW deg k := by
      simpa [degW] using hent k j
    rw [hsym, div_le_iff₀ (degW_pos deg k)]
    linarith
  calc ∑ k ∈ (col j).support, ‖(col j) k‖ / degW deg k
      ≤ (col j).support.card • C := Finset.sum_le_card_nsmul _ _ _ hterm
    _ = (col j).support.card * C := by rw [nsmul_eq_mul]
    _ ≤ M * C := mul_le_mul_of_nonneg_right (by exact_mod_cast hcard j) hC
    _ = C * M := by ring

/-- The **commutator gate** of a graded band matrix. -/
theorem wComm_of_gradedBand (hC : 0 ≤ C)
    (hcard : ∀ k, (col k).support.card ≤ M)
    (hband : ∀ k, ∀ j ∈ (col k).support, ((deg j : ℤ) - (deg k : ℤ)).natAbs ≤ D)
    (hent : ∀ k j, ‖(col k) j‖ ≤ C * ((deg k : ℝ) + 1)) :
    WCommBound (degW deg) col (C * M * D * (D + 2)) := by
  intro k
  set w := degW deg with hw
  have hterm : ∀ j ∈ (col k).support,
      ‖(col k) j‖ * |w j ^ 2 - w k ^ 2| / (w k * w j) ≤ C * D * (D + 2) := by
    intro j hj
    have hwk : 0 < w k := degW_pos deg k
    have hwj : 0 < w j := degW_pos deg j
    have hwj1 : 1 ≤ w j := degW_ge_one deg j
    have hentkj : ‖(col k) j‖ ≤ C * w k := by simpa [hw, degW] using hent k j
    have hbandkj := hband k j hj
    have hdiff : |w j - w k| ≤ (D : ℝ) := by
      have h1 : |((deg j : ℤ) - (deg k : ℤ))| ≤ (D : ℤ) := by
        rw [Int.abs_eq_natAbs]
        exact_mod_cast hbandkj
      obtain ⟨hl, hr⟩ := abs_le.mp h1
      have hl' : -(D : ℝ) ≤ (deg j : ℝ) - (deg k : ℝ) := by exact_mod_cast hl
      have hr' : (deg j : ℝ) - (deg k : ℝ) ≤ (D : ℝ) := by exact_mod_cast hr
      have : |(deg j : ℝ) - (deg k : ℝ)| ≤ (D : ℝ) := abs_le.mpr ⟨hl', hr'⟩
      have hwdiff : w j - w k = (deg j : ℝ) - (deg k : ℝ) := by
        simp only [hw, degW]; ring
      rw [hwdiff]
      exact this
    have hsplit : |w j ^ 2 - w k ^ 2| = |w j - w k| * (w j + w k) := by
      have : w j ^ 2 - w k ^ 2 = (w j - w k) * (w j + w k) := by ring
      rw [this, abs_mul, abs_of_nonneg (by linarith : (0:ℝ) ≤ w j + w k)]
    have hwkle : w k ≤ w j + D := by
      have := abs_le.mp hdiff
      linarith [this.1, this.2]
    have hnum : ‖(col k) j‖ * |w j ^ 2 - w k ^ 2| ≤ (C * w k) * ((D : ℝ) * (w j + w k)) := by
      refine mul_le_mul hentkj ?_ (abs_nonneg _) (mul_nonneg hC hwk.le)
      rw [hsplit]
      exact mul_le_mul_of_nonneg_right hdiff (by linarith)
    rw [div_le_iff₀ (mul_pos hwk hwj)]
    have hD0 : (0:ℝ) ≤ (D : ℝ) := by positivity
    have hsum : w j + w k ≤ ((D : ℝ) + 2) * w j := by nlinarith
    have hfac : (D : ℝ) * (w j + w k) ≤ (D : ℝ) * (((D : ℝ) + 2) * w j) :=
      mul_le_mul_of_nonneg_left hsum hD0
    have hstep : (C * w k) * ((D : ℝ) * (w j + w k)) ≤ C * D * (D + 2) * (w k * w j) := by
      calc (C * w k) * ((D : ℝ) * (w j + w k))
          ≤ (C * w k) * ((D : ℝ) * (((D : ℝ) + 2) * w j)) :=
            mul_le_mul_of_nonneg_left hfac (mul_nonneg hC hwk.le)
        _ = C * D * (D + 2) * (w k * w j) := by ring
    exact le_trans hnum hstep
  calc ∑ j ∈ (col k).support, ‖(col k) j‖ * |w j ^ 2 - w k ^ 2| / (w k * w j)
      ≤ (col k).support.card • (C * D * (D + 2)) := Finset.sum_le_card_nsmul _ _ _ hterm
    _ = (col k).support.card * (C * D * (D + 2)) := by rw [nsmul_eq_mul]
    _ ≤ M * (C * D * (D + 2)) := by
        refine mul_le_mul_of_nonneg_right (by exact_mod_cast hcard k) ?_
        have hD0 : (0:ℝ) ≤ (D : ℝ) := by positivity
        have : (0:ℝ) ≤ (D : ℝ) + 2 := by linarith
        exact mul_nonneg (mul_nonneg hC hD0) this
    _ = C * M * D * (D + 2) := by ring

/-- **Essential self-adjointness of `dΓ(A)` for a graded band one-particle matrix.** -/
theorem dGamma_essentiallySelfAdjointOn_core_gradedBand (hC : 0 ≤ C) (hherm : IsHermCol col)
    (hcard : ∀ k, (col k).support.card ≤ M)
    (hband : ∀ k, ∀ j ∈ (col k).support, ((deg j : ℤ) - (deg k : ℤ)).natAbs ≤ D)
    (hent : ∀ k j, ‖(col k) j‖ ≤ C * ((deg k : ℝ) + 1)) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp col) :=
  dGamma_essentiallySelfAdjointOn_core_w (degW_ge_one deg) hherm
    (wRow_of_gradedBand hC hcard hent) (wCol_of_gradedBand hC hherm hcard hent)
    (mul_nonneg hC (by positivity)) (wComm_of_gradedBand hC hcard hband hent)

end

end BookProof.GradedBandSchur
