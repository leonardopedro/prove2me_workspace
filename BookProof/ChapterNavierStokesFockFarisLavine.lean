import Mathlib
import BookProof.ChapterNavierStokesSecondQuant
import BookProof.ChapterNavierStokesFarisLavineLift

/-!
# The Faris–Lavine data on the Fock space

This module puts the two previous ones together.  `ChapterNavierStokesSecondQuant`
lifts essential self-adjointness from the sectors of the Fock space
`⨁ₘ Sₘ` to the finite-particle domain, and `ChapterNavierStokesFarisLavineLift`
analyses what happens to the two Faris–Lavine inequalities when the
one-particle operators are summed over the particles of a sector.  Here the
inequalities are transported to the Fock space itself:

* `fockOp_isSymmetricDom` — a sector-wise symmetric operator is symmetric on the
  finite-particle domain;
* `fockOp_norm_le_of_sectors` — the relative bound `‖Ĥψ‖ ≤ c₁‖N̂ψ‖` holds on the
  Fock space as soon as it holds in every sector with the same constant;
* `fockOp_norm_inner_le_of_sectors` — likewise for the form bound
  `|⟪ψ, Âψ⟫| ≤ c₂ Re⟪ψ, N̂ψ⟫`, which applied to `Â = [Ĥ, N̂]` is the
  Faris–Lavine commutator bound;
* `fockOp_commDom` — the commutator of two second quantizations is the second
  quantization of the sector-wise commutators, so the previous item does apply
  to it;
* `fockOp_hasZeroDeficiencyOn_of_farisLavine` — the assembled statement: given
  the Faris–Lavine criterion (as a named hypothesis, exactly as elsewhere in this
  project — it is never an `axiom`), sector-wise symmetry, and the two
  sector-wise inequalities, the second-quantized Hamiltonian has vanishing
  adjoint deficiency on the finite-particle domain of the Fock space.

`fockComparison_hasZeroDeficiencyOn` records the unconditional half in a
concrete case: the second quantization of the one-particle comparison operator
`n = ∑πᵢ² + ∑Vᵢ² + I` of the fiber momentum representation is essentially
self-adjoint on the finite-particle domain of the corresponding Fock space, and
that domain is a proper subspace.

## Scope

Essential self-adjointness of the continuum Navier–Stokes Hamiltonian is **not**
claimed.  The Faris–Lavine criterion is an input here, and its two inequalities
are proved here only to *lift*: whether they hold for the one-particle
Navier–Stokes operator is not settled in this project.

**Update.**  The named hypothesis `farisLavine` of
`fockOp_hasZeroDeficiencyOn_of_farisLavine` is stated in the *unrestricted* form
(relative bound plus commutator bound, with no positivity of `N` and no
surjectivity of `N + 1`), and that form of the criterion is refutable —
`BookProof.FarisLavine.not_farisLavine_criterion_of_relative_bound`.  The
hypothesis-free replacement is in
`BookProof.ChapterNavierStokesIkebeKato` and
`BookProof.ChapterNavierStokesMomentumEsa`: there the comparison operator is
taken on its maximal domain, where positivity, surjectivity of `N + 1` and the
core property of the finite-mode states are all *proved*, and the criterion
itself is the theorem
`BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine`.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace SecondQuant

open FarisLavineLift

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}

/-! ## Algebra of second quantizations -/

theorem fockOp_comp (A B : ∀ m, D m →ₗ[ℂ] D m) :
    fockOp (fun m => (A m).comp (B m)) = (fockOp A).comp (fockOp B) := by
  refine LinearMap.ext fun v => Subtype.ext (lp.ext ?_)
  funext m
  rfl

theorem fockOp_sub (A B : ∀ m, D m →ₗ[ℂ] D m) :
    fockOp (fun m => A m - B m) = fockOp A - fockOp B := by
  refine LinearMap.ext fun v => Subtype.ext (lp.ext ?_)
  funext m
  rfl

/-- **The commutator of second-quantized operators is the second quantization of
the sector-wise commutators.** -/
theorem fockOp_commDom (A B : ∀ m, D m →ₗ[ℂ] D m) :
    fockOp (fun m => commDom (A m) (B m)) = commDom (fockOp A) (fockOp B) := by
  rw [commDom, ← fockOp_comp, ← fockOp_comp, ← fockOp_sub]
  rfl

/-! ## Symmetry -/

/-- A sector-wise symmetric family second-quantizes to a symmetric operator on
the finite-particle domain. -/
theorem fockOp_isSymmetricDom (A : ∀ m, D m →ₗ[ℂ] D m)
    (hA : ∀ m, FullEsa.IsSymmetricDom (A m)) :
    FullEsa.IsSymmetricDom (fockOp A) := by
  intro x y
  have h1 := lp.hasSum_inner (𝕜 := ℂ) ((fockOp A x : fockCore D) : lp S 2) ((y : lp S 2))
  have h2 := lp.hasSum_inner (𝕜 := ℂ) ((x : lp S 2)) ((fockOp A y : fockCore D) : lp S 2)
  have hterm : ∀ m : ι,
      (inner ℂ (((fockOp A x : fockCore D) : lp S 2) m) ((y : lp S 2) m) : ℂ)
        = inner ℂ ((x : lp S 2) m) (((fockOp A y : fockCore D) : lp S 2) m) := by
    intro m
    exact hA m ⟨(x : lp S 2) m, (x.2).2 m⟩ ⟨(y : lp S 2) m, (y.2).2 m⟩
  have h2' : HasSum
      (fun m => (inner ℂ (((fockOp A x : fockCore D) : lp S 2) m) ((y : lp S 2) m) : ℂ))
      (inner ℂ ((x : lp S 2)) ((fockOp A y : fockCore D) : lp S 2)) := by
    simpa only [hterm] using h2
  exact h1.unique h2'

/-! ## The relative bound -/

private theorem rpow_two_eq (x : ℝ) : x ^ ((2 : ℝ≥0∞).toReal) = x ^ 2 := by
  have h : ((2 : ℝ≥0∞).toReal) = ((2 : ℕ) : ℝ) := by norm_num
  rw [h, Real.rpow_natCast]

/-- **The relative bound lifts to the Fock space.**  If in every sector
`‖Hₘ x‖ ≤ c₁ ‖Nₘ x‖`, then `‖Ĥψ‖ ≤ c₁‖N̂ψ‖` for every finite-particle state:
the squared norms are the (convergent) sums of the sector contributions. -/
theorem fockOp_norm_le_of_sectors (H N : ∀ m, D m →ₗ[ℂ] D m) (cst : ℝ) (hc : 0 ≤ cst)
    (hb : ∀ (m : ι) (x : D m), ‖((H m x : D m) : S m)‖ ≤ cst * ‖((N m x : D m) : S m)‖)
    (v : fockCore D) :
    ‖((fockOp H v : fockCore D) : lp S 2)‖ ≤ cst * ‖((fockOp N v : fockCore D) : lp S 2)‖ := by
  have hp : (0 : ℝ) < (2 : ℝ≥0∞).toReal := by norm_num
  have h1 := lp.hasSum_norm hp ((fockOp H v : fockCore D) : lp S 2)
  have h2 := (lp.hasSum_norm hp ((fockOp N v : fockCore D) : lp S 2)).mul_left (cst ^ 2)
  have hterm : ∀ m : ι,
      ‖(((fockOp H v : fockCore D) : lp S 2) m)‖ ^ ((2 : ℝ≥0∞).toReal)
        ≤ cst ^ 2 * ‖(((fockOp N v : fockCore D) : lp S 2) m)‖ ^ ((2 : ℝ≥0∞).toReal) := by
    intro m
    rw [rpow_two_eq _, rpow_two_eq _]
    have hbm := hb m ⟨(v : lp S 2) m, (v.2).2 m⟩
    have hHm : (((fockOp H v : fockCore D) : lp S 2) m)
        = ((H m ⟨(v : lp S 2) m, (v.2).2 m⟩ : D m) : S m) := rfl
    have hNm : (((fockOp N v : fockCore D) : lp S 2) m)
        = ((N m ⟨(v : lp S 2) m, (v.2).2 m⟩ : D m) : S m) := rfl
    rw [hHm, hNm]
    nlinarith [norm_nonneg ((H m ⟨(v : lp S 2) m, (v.2).2 m⟩ : D m) : S m),
      norm_nonneg ((N m ⟨(v : lp S 2) m, (v.2).2 m⟩ : D m) : S m), hbm,
      mul_nonneg hc (norm_nonneg ((N m ⟨(v : lp S 2) m, (v.2).2 m⟩ : D m) : S m))]
  have hsum := hasSum_le hterm h1 h2
  rw [rpow_two_eq _, rpow_two_eq _] at hsum
  nlinarith [norm_nonneg ((fockOp H v : fockCore D) : lp S 2),
    norm_nonneg ((fockOp N v : fockCore D) : lp S 2),
    mul_nonneg hc (norm_nonneg ((fockOp N v : fockCore D) : lp S 2))]

/-! ## The form bound -/

/-- **The form bound lifts to the Fock space.**  Applied to the sector-wise
commutators `Aₘ = [Hₘ, Nₘ]` this is the Faris–Lavine commutator bound for the
second-quantized pair. -/
theorem fockOp_norm_inner_le_of_sectors (A N : ∀ m, D m →ₗ[ℂ] D m) (c₂ : ℝ)
    (hb : ∀ (m : ι) (x : D m), ‖(inner ℂ ((x : S m)) ((A m x : D m) : S m) : ℂ)‖
      ≤ c₂ * (inner ℂ ((x : S m)) ((N m x : D m) : S m) : ℂ).re)
    (v : fockCore D) :
    ‖(inner ℂ ((v : lp S 2)) ((fockOp A v : fockCore D) : lp S 2) : ℂ)‖
      ≤ c₂ * (inner ℂ ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2) : ℂ).re := by
  have hA := lp.hasSum_inner (𝕜 := ℂ) ((v : lp S 2)) ((fockOp A v : fockCore D) : lp S 2)
  have hN := lp.hasSum_inner (𝕜 := ℂ) ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2)
  have hNre : HasSum
      (fun m => (inner ℂ ((v : lp S 2) m) (((fockOp N v : fockCore D) : lp S 2) m) : ℂ).re)
      ((inner ℂ ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2) : ℂ).re) :=
    hN.map Complex.reAddGroupHom Complex.continuous_re
  have hterm : ∀ m : ι,
      ‖(inner ℂ ((v : lp S 2) m) (((fockOp A v : fockCore D) : lp S 2) m) : ℂ)‖
        ≤ c₂ * (inner ℂ ((v : lp S 2) m)
            (((fockOp N v : fockCore D) : lp S 2) m) : ℂ).re := by
    intro m
    exact hb m ⟨(v : lp S 2) m, (v.2).2 m⟩
  have hmaj := hNre.mul_left c₂
  have hsummable_norm : Summable fun m : ι =>
      ‖(inner ℂ ((v : lp S 2) m) (((fockOp A v : fockCore D) : lp S 2) m) : ℂ)‖ :=
    Summable.of_nonneg_of_le (fun m => norm_nonneg _) hterm hmaj.summable
  calc ‖(inner ℂ ((v : lp S 2)) ((fockOp A v : fockCore D) : lp S 2) : ℂ)‖
      = ‖∑' m : ι, (inner ℂ ((v : lp S 2) m)
          (((fockOp A v : fockCore D) : lp S 2) m) : ℂ)‖ := by rw [hA.tsum_eq]
    _ ≤ ∑' m : ι, ‖(inner ℂ ((v : lp S 2) m)
          (((fockOp A v : fockCore D) : lp S 2) m) : ℂ)‖ :=
        norm_tsum_le_tsum_norm hsummable_norm
    _ ≤ ∑' m : ι, c₂ * (inner ℂ ((v : lp S 2) m)
          (((fockOp N v : fockCore D) : lp S 2) m) : ℂ).re :=
        Summable.tsum_mono hsummable_norm hmaj.summable hterm
    _ = c₂ * (inner ℂ ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2) : ℂ).re :=
        hmaj.tsum_eq

/-- **The comparison operator of the Fock space still dominates the identity.**
If every sector operator satisfies `⟪x, Nₘ x⟫ ≥ ‖x‖²`, then `N̂ ≥ I` on the
finite-particle domain: the strict positivity that makes `N̂` a legitimate
Faris–Lavine comparison operator survives second quantization. -/
theorem fockOp_ge_norm_sq (N : ∀ m, D m →ₗ[ℂ] D m)
    (hb : ∀ (m : ι) (x : D m),
      ‖(x : S m)‖ ^ 2 ≤ (inner ℂ ((x : S m)) ((N m x : D m) : S m) : ℂ).re)
    (v : fockCore D) :
    ‖(v : lp S 2)‖ ^ 2
      ≤ (inner ℂ ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2) : ℂ).re := by
  have hp : (0 : ℝ) < (2 : ℝ≥0∞).toReal := by norm_num
  have hnorm := lp.hasSum_norm hp ((v : lp S 2))
  have hN := lp.hasSum_inner (𝕜 := ℂ) ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2)
  have hNre : HasSum
      (fun m => (inner ℂ ((v : lp S 2) m) (((fockOp N v : fockCore D) : lp S 2) m) : ℂ).re)
      ((inner ℂ ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2) : ℂ).re) :=
    hN.map Complex.reAddGroupHom Complex.continuous_re
  have hterm : ∀ m : ι, ‖((v : lp S 2) m)‖ ^ ((2 : ℝ≥0∞).toReal)
      ≤ (inner ℂ ((v : lp S 2) m)
          (((fockOp N v : fockCore D) : lp S 2) m) : ℂ).re := by
    intro m
    rw [rpow_two_eq]
    exact hb m ⟨(v : lp S 2) m, (v.2).2 m⟩
  have hsum := hasSum_le hterm hnorm hNre
  rwa [rpow_two_eq] at hsum

/-! ## The assembled Faris–Lavine statement on the Fock space -/

/-- **Faris–Lavine on the Fock space.**  Given

* the Faris–Lavine criterion as a named hypothesis (Faris & Lavine 1974,
  Corollary 1.1; Reed–Simon Vol. II Theorem X.28) — it is *not* proved in this
  project, and it is never an `axiom`;
* dense sector domains, so that the finite-particle domain is dense;
* sector-wise symmetry of the Hamiltonian;
* the sector-wise relative bound and the sector-wise commutator form bound,

the second-quantized Hamiltonian has vanishing adjoint deficiency on the
finite-particle domain of the Fock space.  The point of the theorem is that the
two analytic inequalities are only ever needed *sector by sector*: the passage to
the infinitely many degrees of freedom of the Fock space costs nothing. -/
theorem fockOp_hasZeroDeficiencyOn_of_farisLavine
    (H N : ∀ m, D m →ₗ[ℂ] D m) (c₁ c₂ : ℝ) (hc₁ : 0 ≤ c₁) (hc₂ : 0 ≤ c₂)
    (farisLavine : ∀ (D' : Submodule ℂ (lp S 2)) (H' N' : D' →ₗ[ℂ] D') (a b : ℝ),
      Dense (D' : Set (lp S 2)) →
      (∀ x y : D', (inner ℂ (H' x : lp S 2) (y : lp S 2) : ℂ)
        = inner ℂ (x : lp S 2) (H' y : lp S 2)) →
      (∀ v : D', ‖(H' v : lp S 2)‖ ≤ a * ‖(N' v : lp S 2)‖) →
      (∀ v : D', ‖(inner ℂ (v : lp S 2)
          ((H' (N' v) : lp S 2) - (N' (H' v) : lp S 2)) : ℂ)‖
        ≤ b * ‖(inner ℂ (v : lp S 2) (N' v : lp S 2) : ℂ)‖) →
      HasZeroDeficiencyOn D' H')
    (hdense : ∀ m, Dense ((D m : Submodule ℂ (S m)) : Set (S m)))
    (hsym : ∀ m, FullEsa.IsSymmetricDom (H m))
    (hbound : ∀ (m : ι) (x : D m), ‖((H m x : D m) : S m)‖ ≤ c₁ * ‖((N m x : D m) : S m)‖)
    (hcomm : ∀ (m : ι) (x : D m),
      ‖(inner ℂ ((x : S m)) ((commDom (H m) (N m) x : D m) : S m) : ℂ)‖
        ≤ c₂ * (inner ℂ ((x : S m)) ((N m x : D m) : S m) : ℂ).re) :
    HasZeroDeficiencyOn (fockCore D) (fockOp H) := by
  refine ns_esa_of_farisLavine_dense (fockCore D) (fockOp H) (fockOp N) c₁ c₂ farisLavine
    (fockCore_dense hdense) (fockOp_isSymmetricDom H hsym)
    (fockOp_norm_le_of_sectors H N c₁ hc₁ hbound) ?_
  intro v
  have hcommEq : ((fockOp H (fockOp N v) : fockCore D) : lp S 2)
      - ((fockOp N (fockOp H v) : fockCore D) : lp S 2)
      = ((fockOp (fun m => commDom (H m) (N m)) v : fockCore D) : lp S 2) := by
    rw [fockOp_commDom]
    rfl
  rw [hcommEq]
  refine le_trans (fockOp_norm_inner_le_of_sectors (fun m => commDom (H m) (N m)) N c₂
    hcomm v) ?_
  exact mul_le_mul_of_nonneg_left (Complex.re_le_norm _) hc₂

/-! ## A concrete Fock space over the fiber momentum representation -/

section ConcreteFock

open FarisLavineLift LpNat DiagonalEsa

/-- The sector spaces of the concrete example: every sector is a copy of the
fiber space `ℓ²(ℕ)` of the momentum representation. -/
abbrev fiberSector : ℕ → Type := fun _ => L2N

/-- The sector domains: the finite-mode core of each fiber, the analogue of
`C_c^∞`. -/
noncomputable def fiberCore : ∀ m : ℕ, Submodule ℂ (fiberSector m) := fun _ => lpFiniteModes ℕ

/-- **The second quantization `N̂ = dΓ(n) + I` of the one-particle comparison
operator** `n = ∑πᵢ² + ∑Vᵢ² + I`, in the fiber momentum representation. -/
noncomputable def fockComparison (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    fockCore fiberCore →ₗ[ℂ] fockCore fiberCore :=
  fockOp (fun _ => (diagComparisonData d p q).comparison)

/-- **The comparison operator of the Fock space is essentially self-adjoint on
the finite-particle domain** — unconditionally, for arbitrary momentum and
advection symbols.  This is the Fock-space "cage" the Faris–Lavine criterion
asks for. -/
theorem fockComparison_hasZeroDeficiencyOn (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    HasZeroDeficiencyOn (fockCore fiberCore) (fockComparison d p q) :=
  fockOp_hasZeroDeficiencyOn _ fun _ => diagComparison_hasZeroDeficiencyOn d p q

/-- **The Fock comparison operator dominates the identity**, `N̂ ≥ I`: the
"cage" is positive on every finite-particle state. -/
theorem fockComparison_ge_norm_sq (d : ℕ) (p q : Fin d → ℕ → ℝ) (v : fockCore fiberCore) :
    ‖(v : lp fiberSector 2)‖ ^ 2
      ≤ (inner ℂ ((v : lp fiberSector 2))
          ((fockComparison d p q v : fockCore fiberCore) : lp fiberSector 2) : ℂ).re :=
  fockOp_ge_norm_sq _ (fun _ x => (diagComparisonData d p q).comparison_ge_norm_sq x) v

/-- The finite-particle domain is dense in the Fock space. -/
theorem fockComparison_dense :
    Dense ((fockCore fiberCore : Submodule ℂ (lp fiberSector 2)) : Set (lp fiberSector 2)) :=
  fockCore_dense fun _ => lpFiniteModes_dense

/-- …and it is a *proper* subspace: the statement above is a genuine
unbounded-operator statement about infinitely many degrees of freedom. -/
theorem fockComparison_domain_ne_top :
    (fockCore fiberCore : Submodule ℂ (lp fiberSector 2)) ≠ ⊤ :=
  fockCore_ne_top _ (fun _ => (basis 0 : L2N)) (fun _ => by
    simpa using norm_basis 0)

end ConcreteFock

end SecondQuant

end BookProof.NavierStokesFlow
