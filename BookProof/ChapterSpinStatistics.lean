import Mathlib

/-!
# Chapter "Wave-function parametrization of a probability measure", §6 —
the **two-mode fermionic CAR algebra** for a finite sample space
(`ℤ₂ × ℤ₂`) and the spin–statistics dichotomy

This file formalizes the self-contained mathematical content of the section
*"6. Free field parametrization for finite sample spaces and the spin-statistics
theorem"* (`book.tex` line ~1816).  There the book observes that a finite sample
space such as `ℤ₂` is parametrized by a **fermionic** Fock space
`Γ^a(L²(ℤ₂))`, and that for a *product* `ℤ₂ × ℤ₂` one must take the graded
tensor product `Γ^s(L²(ℤ₂)) ⊗ Γ^a(L²(ℤ₂))` so that the two modes do **not**
produce spurious non-null products of creation operators — i.e. the two
fermionic modes must **anticommute**.  This anticommutation (as opposed to the
commutation of bosonic modes) is exactly the algebraic content underlying the
**spin–statistics** correspondence the section is about.

The single-mode ghost/fermion CAR `{ψ, ψ†} = 1` on `ℂ²` is already in
`BookProof/ChapterNavierStokes.lean`.  This file builds the **two-mode**
fermionic Fock space `ℂ⁴ ≅ ℂ² ⊗ ℂ²` via the Jordan–Wigner realization

* mode 1: `b₁ = a ⊗ I`,
* mode 2: `b₂ = Z ⊗ a`,   with `a = !![0,1;0,0]` the single-mode annihilation and
  `Z = diag(1,-1)` the fermion-parity string,

which on `ℂ⁴` (basis order `|n₁ n₂⟩ = |00⟩, |01⟩, |10⟩, |11⟩`, `|00⟩` the vacuum)
are the explicit `4×4` matrices

* `fermiAnnih1` (`b₁`) `= !![0,0,1,0; 0,0,0,1; 0,0,0,0; 0,0,0,0]`,
* `fermiAnnih2` (`b₂`) `= !![0,1,0,0; 0,0,0,0; 0,0,0,-1; 0,0,0,0]`,

with creation operators the conjugate-transpose (adjoint) `bᵢ†`.

We prove, all `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`):

* `fermiCreate1_eq` / `fermiCreate2_eq` — the explicit matrix form of `b₁†`, `b₂†`;
* `fermi_CAR₁` / `fermi_CAR₂` — the diagonal CAR `{bᵢ, bᵢ†} = 1`;
* `fermi_CAR_cross` / `fermi_CAR_cross'` — the **off-diagonal** CAR
  `{b₁, b₂†} = 0`, `{b₂, b₁†} = 0` (distinct modes are canonically anticommuting);
* `fermiAnticomm_annih` / `fermiAnticomm_create` — `{b₁, b₂} = 0`, `{b₁†, b₂†} = 0`
  (the **fermionic statistics**: the two modes anticommute, so
  `b₁ b₂ = - b₂ b₁`);
* `fermiAnnih₁_sq` … `fermiCreate₂_sq` — nilpotency `bᵢ² = 0`, `bᵢ†² = 0`
  (Pauli exclusion per mode);
* `fermiNumber₁_eq` / `fermiNumber₂_eq` — the mode number operators
  `Nᵢ = bᵢ† bᵢ`, with `fermiNumber₁_hermitian`/`fermiNumber₁_idem` (each is a
  Hermitian projection with eigenvalues `0,1`) and `fermiNumber_commute`
  (`N₁ N₂ = N₂ N₁`, so occupation numbers are simultaneously measurable);
* `fermiTotalNumber_eq` — the total number operator `N = N₁ + N₂ = diag(0,1,1,2)`
  counts the fermionic occupation of the two-mode Fock space `ℂ⁴`.

The point of the section — that this fermionic (anticommuting) parametrization is
genuinely distinct from the bosonic (commuting) one, and that certain symmetry
transformations are representable only by one or the other (the spin–statistics
theorem) — is a representation-theoretic statement left as prose; what is
formalized here is the exact two-mode CAR algebra it rests on.
-/

namespace BookProof.SpinStatistics

open Matrix

/-- Mode-1 fermionic **annihilation** operator `b₁ = a ⊗ I` on the two-mode
Fock space `ℂ⁴ ≅ ℂ² ⊗ ℂ²`.  Basis order `|n₁ n₂⟩ = |00⟩,|01⟩,|10⟩,|11⟩`, with
`|00⟩` the vacuum; `b₁` lowers the mode-1 occupation. -/
noncomputable def fermiAnnih1 : Matrix (Fin 4) (Fin 4) ℂ :=
  !![0,0,1,0; 0,0,0,1; 0,0,0,0; 0,0,0,0]

/-- Mode-2 fermionic **annihilation** operator `b₂ = Z ⊗ a` (Jordan–Wigner:
the fermion-parity string `Z = diag(1,-1)` on mode 1 makes the two modes
anticommute). -/
noncomputable def fermiAnnih2 : Matrix (Fin 4) (Fin 4) ℂ :=
  !![0,1,0,0; 0,0,0,0; 0,0,0,-1; 0,0,0,0]

/-- Mode-1 **creation** operator `b₁†`, the (conjugate-transpose) adjoint of `b₁`. -/
noncomputable def fermiCreate1 : Matrix (Fin 4) (Fin 4) ℂ := fermiAnnih1ᴴ

/-- Mode-2 **creation** operator `b₂†`, the (conjugate-transpose) adjoint of `b₂`. -/
noncomputable def fermiCreate2 : Matrix (Fin 4) (Fin 4) ℂ := fermiAnnih2ᴴ

/-- `b₁†` is by definition the conjugate transpose (adjoint) of `b₁`. -/
theorem fermiCreate1_eq_conjTranspose : fermiCreate1 = fermiAnnih1ᴴ := rfl

/-- `b₂†` is by definition the conjugate transpose (adjoint) of `b₂`. -/
theorem fermiCreate2_eq_conjTranspose : fermiCreate2 = fermiAnnih2ᴴ := rfl

/-- Explicit matrix form of the mode-1 creation operator. -/
theorem fermiCreate1_eq : fermiCreate1 = !![0,0,0,0; 0,0,0,0; 1,0,0,0; 0,1,0,0] := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [fermiCreate1, fermiAnnih1, Matrix.conjTranspose_apply]

/-- Explicit matrix form of the mode-2 creation operator. -/
theorem fermiCreate2_eq : fermiCreate2 = !![0,0,0,0; 1,0,0,0; 0,0,0,0; 0,0,-1,0] := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [fermiCreate2, fermiAnnih2, Matrix.conjTranspose_apply]

/-- **Diagonal CAR for mode 1:** `{b₁, b₁†} = b₁ b₁† + b₁† b₁ = 1`. -/
theorem fermi_CAR₁ : fermiAnnih1 * fermiCreate1 + fermiCreate1 * fermiAnnih1 = 1 := by
  rw [fermiCreate1_eq]
  ext i j; fin_cases i <;> fin_cases j <;> simp [fermiAnnih1]

/-- **Diagonal CAR for mode 2:** `{b₂, b₂†} = b₂ b₂† + b₂† b₂ = 1`. -/
theorem fermi_CAR₂ : fermiAnnih2 * fermiCreate2 + fermiCreate2 * fermiAnnih2 = 1 := by
  rw [fermiCreate2_eq]
  ext i j; fin_cases i <;> fin_cases j <;> simp [fermiAnnih2]

/-- **Off-diagonal CAR:** distinct modes canonically anticommute,
`{b₁, b₂†} = b₁ b₂† + b₂† b₁ = 0`. -/
theorem fermi_CAR_cross : fermiAnnih1 * fermiCreate2 + fermiCreate2 * fermiAnnih1 = 0 := by
  rw [fermiCreate2_eq]
  ext i j; fin_cases i <;> fin_cases j <;> simp [fermiAnnih1]

/-- **Off-diagonal CAR:** `{b₂, b₁†} = b₂ b₁† + b₁† b₂ = 0`. -/
theorem fermi_CAR_cross' : fermiAnnih2 * fermiCreate1 + fermiCreate1 * fermiAnnih2 = 0 := by
  rw [fermiCreate1_eq]
  ext i j; fin_cases i <;> fin_cases j <;> simp [fermiAnnih2]

/-- **Fermionic statistics:** the two annihilation modes anticommute,
`{b₁, b₂} = b₁ b₂ + b₂ b₁ = 0` (equivalently `b₁ b₂ = - b₂ b₁`).  This is the
algebraic content distinguishing the fermionic parametrization from a bosonic
(commuting) one. -/
theorem fermiAnticomm_annih : fermiAnnih1 * fermiAnnih2 + fermiAnnih2 * fermiAnnih1 = 0 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [fermiAnnih1, fermiAnnih2]

/-- The two creation modes anticommute, `{b₁†, b₂†} = 0`. -/
theorem fermiAnticomm_create :
    fermiCreate1 * fermiCreate2 + fermiCreate2 * fermiCreate1 = 0 := by
  rw [fermiCreate1_eq, fermiCreate2_eq]
  ext i j; fin_cases i <;> fin_cases j <;> simp

/-- Pauli exclusion, mode 1: `b₁² = 0`. -/
theorem fermiAnnih₁_sq : fermiAnnih1 * fermiAnnih1 = 0 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [fermiAnnih1]

/-- Pauli exclusion, mode 2: `b₂² = 0`. -/
theorem fermiAnnih₂_sq : fermiAnnih2 * fermiAnnih2 = 0 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [fermiAnnih2]

/-- Pauli exclusion, mode 1: `b₁†² = 0`. -/
theorem fermiCreate₁_sq : fermiCreate1 * fermiCreate1 = 0 := by
  rw [fermiCreate1_eq]; ext i j; fin_cases i <;> fin_cases j <;> simp

/-- Pauli exclusion, mode 2: `b₂†² = 0`. -/
theorem fermiCreate₂_sq : fermiCreate2 * fermiCreate2 = 0 := by
  rw [fermiCreate2_eq]; ext i j; fin_cases i <;> fin_cases j <;> simp

/-- Mode-1 **number operator** `N₁ = b₁† b₁`. -/
noncomputable def fermiNumber1 : Matrix (Fin 4) (Fin 4) ℂ := fermiCreate1 * fermiAnnih1

/-- Mode-2 **number operator** `N₂ = b₂† b₂`. -/
noncomputable def fermiNumber2 : Matrix (Fin 4) (Fin 4) ℂ := fermiCreate2 * fermiAnnih2

/-- Explicit form of `N₁ = diag(0,0,1,1)`: it reads off the mode-1 occupation. -/
theorem fermiNumber₁_eq : fermiNumber1 = !![0,0,0,0; 0,0,0,0; 0,0,1,0; 0,0,0,1] := by
  rw [fermiNumber1, fermiCreate1_eq]
  ext i j; fin_cases i <;> fin_cases j <;> simp [fermiAnnih1]

/-- Explicit form of `N₂ = diag(0,1,0,1)`: it reads off the mode-2 occupation. -/
theorem fermiNumber₂_eq : fermiNumber2 = !![0,0,0,0; 0,1,0,0; 0,0,0,0; 0,0,0,1] := by
  rw [fermiNumber2, fermiCreate2_eq]
  ext i j; fin_cases i <;> fin_cases j <;> simp [fermiAnnih2]

/-- Each mode number operator is Hermitian. -/
theorem fermiNumber₁_hermitian : fermiNumber1ᴴ = fermiNumber1 := by
  rw [fermiNumber₁_eq]; ext i j; fin_cases i <;> fin_cases j <;>
    simp [Matrix.conjTranspose_apply]

theorem fermiNumber₂_hermitian : fermiNumber2ᴴ = fermiNumber2 := by
  rw [fermiNumber₂_eq]; ext i j; fin_cases i <;> fin_cases j <;>
    simp [Matrix.conjTranspose_apply]

/-- Each mode number operator is a projection (`Nᵢ² = Nᵢ`); eigenvalues `0,1`. -/
theorem fermiNumber₁_idem : fermiNumber1 * fermiNumber1 = fermiNumber1 := by
  rw [fermiNumber₁_eq]; ext i j; fin_cases i <;> fin_cases j <;> simp

theorem fermiNumber₂_idem : fermiNumber2 * fermiNumber2 = fermiNumber2 := by
  rw [fermiNumber₂_eq]; ext i j; fin_cases i <;> fin_cases j <;> simp

/-- The two mode occupation numbers are **simultaneously measurable**:
`N₁ N₂ = N₂ N₁` (they commute, unlike the anticommuting `bᵢ`). -/
theorem fermiNumber_commute : fermiNumber1 * fermiNumber2 = fermiNumber2 * fermiNumber1 := by
  rw [fermiNumber₁_eq, fermiNumber₂_eq]
  ext i j; fin_cases i <;> fin_cases j <;> simp

/-- The **total number operator** `N = N₁ + N₂ = diag(0,1,1,2)` counts the total
fermionic occupation across the two-mode Fock space `ℂ⁴`. -/
theorem fermiTotalNumber_eq :
    fermiNumber1 + fermiNumber2 = !![0,0,0,0; 0,1,0,0; 0,0,1,0; 0,0,0,2] := by
  rw [fermiNumber₁_eq, fermiNumber₂_eq]
  ext i j; fin_cases i <;> fin_cases j <;> norm_num

end BookProof.SpinStatistics
