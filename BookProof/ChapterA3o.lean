import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3j
import BookProof.ChapterA3n

/-!
# Chapter A, §A.3 — Note 51 / Lemma 52: the arbitrary `N`-fold *antisymmetric* power

Source: `book.tex` §A.3, Notes 50–51 and Lemma 52 (line ~5560), together with
Def 57 (`Pinor₀` = the **antisymmetric** pair of Majorana spinors).

`ChapterA3n` built, for arbitrary `N`, the totally *symmetric* power `V^{⊙N}`
via the symmetrizer `projSym N = (N!)⁻¹·Σ_{σ∈S_N} ρ(σ)`.  This file is the exact
dual construction: the totally *antisymmetric* power (the `N`-fold exterior power
`Λ^N V`), whose base case `N = 2` is the antisymmetric pair `Pinor₀` of Def 57.

It reuses the tensor model of `ChapterA3n` verbatim — the carrier
`MN N = Matrix (Fin N → Fin 4) (Fin N → Fin 4) ℂ`, the tensor operator
`tensorPow`, the permutation representation `permMat`, the diagonal `Spin⁺`
generator `diagGen`, and the uniform parity operator `uniform` — and only changes
the group average from the trivial character to the **sign** character `sgn : S_N → {±1}`.

## The construction

The total **antisymmetrizer**

  `projAnti N := (N!)⁻¹ • Σ_{σ∈S_N} sgn(σ)·permMat σ`

is a genuine projector (`projAnti_idem`) onto the exterior power `Λ^N V`.  Its
idempotency is the *signed* group identity

  `(Σ_σ sgn(σ)·ρ(σ))² = N!·Σ_σ sgn(σ)·ρ(σ)`  (`sum_signed_permMat_sq`),

which holds because `sgn` is a homomorphism valued in `{±1}` (so
`sgn(σ)·sgn(σ⁻¹ρ) = sgn(ρ)` after the reindexing `ρ = στ`).

## The Lemma-52 payoff (antisymmetric case)

Because *every* braiding `permMat σ` already commutes with the diagonal `Spin⁺`
generator `diagGen A` and the uniform parity operator `uniform A`
(`ChapterA3n.permMat_diagGen_comm`, `ChapterA3n.permMat_uniform_comm`), so does
any linear combination of them — in particular the signed average `projAnti N`
(`projAnti_diagGen_comm`, `projAnti_uniform_comm`).  Specialising to the §A.3
data gives the headline statement exactly as in the symmetric case: the
antisymmetric power is a **full-Lorentz** subrepresentation, invariant under the
diagonal `Spin⁺` generators `γ^μγ^ν` (`projAnti_spinGenDiag_comm`) **and** under
diagonal parity `γ⁰⊗…⊗γ⁰` (`projAnti_parityDiag_comm`).

Everything is `sorry`-free / `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`), with **no `EXTERNAL` hypothesis** (Note 50 / Weyl complete
reducibility remains the cited backbone).  Together with `ChapterA3n` this
completes the pair of totally (anti)symmetric tensor-power constructions of
Notes 50–51 / Def 57.
-/

open Matrix
open scoped BigOperators

namespace BookProof.ChapterA3o

open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n

/-- The sign of a permutation as a complex scalar `±1`. -/
noncomputable def signC {N : ℕ} (σ : Equiv.Perm (Fin N)) : ℂ :=
  ((Equiv.Perm.sign σ : ℤ) : ℂ)

/-- The total **antisymmetrizer** `projAnti N = (N!)⁻¹ • Σ_{σ∈S_N} sgn(σ)·permMat σ`
onto the exterior power `Λ^N V`. -/
noncomputable def projAnti (N : ℕ) : MN N :=
  (Nat.factorial N : ℂ)⁻¹ • ∑ σ : Equiv.Perm (Fin N), signC σ • permMat σ

/-! ## The signed group identity -/

/-
The signed core group identity `(Σ_{σ∈S_N} sgn(σ)·ρ(σ))² = N!·Σ_{σ} sgn(σ)·ρ(σ)`.
Multiplying the signed group sum by itself and reindexing `ρ = στ` gives `|S_N| = N!`
copies of the signed group sum, using that `sgn` is a `{±1}`-valued homomorphism.
-/
theorem sum_signed_permMat_sq {N : ℕ} :
    (∑ σ : Equiv.Perm (Fin N), signC σ • permMat σ) *
        (∑ σ : Equiv.Perm (Fin N), signC σ • permMat σ)
      = (Nat.factorial N : ℂ) • ∑ σ : Equiv.Perm (Fin N), signC σ • permMat σ := by
  -- Expand the product of the two sums into a double sum over `σ`, `τ`.
  have h_expand :
      (∑ σ : Equiv.Perm (Fin N), signC σ • permMat σ) *
          (∑ σ : Equiv.Perm (Fin N), signC σ • permMat σ)
        = ∑ σ : Equiv.Perm (Fin N), ∑ τ : Equiv.Perm (Fin N),
            (signC σ * signC τ) • permMat (σ * τ) := by
    simp only [Finset.sum_mul_sum]
    simp [mul_comm, smul_smul, permMat_mul]
  -- For each fixed `σ`, reindex the inner sum by `ρ = σ * τ`; the signed scalar
  -- collapses to `signC ρ`, independent of `σ`.
  have h_inner_sum : ∀ σ : Equiv.Perm (Fin N),
      ∑ τ : Equiv.Perm (Fin N), (signC σ * signC τ) • permMat (σ * τ)
        = ∑ ρ : Equiv.Perm (Fin N), signC ρ • permMat ρ := by
    intro σ
    apply Finset.sum_bij (fun τ _ => σ * τ)
    · simp
    · aesop
    · exact fun b _ => ⟨σ⁻¹ * b, Finset.mem_univ _, by simp⟩
    · simp [signC]
  simp_all [Finset.card_univ, Fintype.card_perm]
  norm_num [Algebra.smul_def]

/-- `projAnti N` is idempotent — a genuine projector onto the exterior power. -/
theorem projAnti_idem {N : ℕ} : projAnti N * projAnti N = projAnti N := by
  have h : (Nat.factorial N : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr (Nat.factorial_ne_zero N)
  unfold projAnti
  rw [Matrix.smul_mul, Matrix.mul_smul, sum_signed_permMat_sq, smul_smul, smul_smul,
    mul_assoc, inv_mul_cancel₀ h, mul_one]

/-! ## The Lemma-52 payoff — the antisymmetric power is a full-Lorentz subrepresentation -/

/-- The antisymmetrizer commutes with the uniform (diagonal-parity) operator,
because every braiding `permMat σ` does. -/
theorem projAnti_uniform_comm {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) :
    projAnti N * uniform A = uniform A * projAnti N := by
  unfold projAnti
  simp only [Finset.sum_mul, Finset.mul_sum,
    smul_mul_assoc, mul_smul_comm, permMat_uniform_comm]

/-- The antisymmetrizer commutes with the diagonal `Spin⁺` generator,
because every braiding `permMat σ` does. -/
theorem projAnti_diagGen_comm {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) :
    projAnti N * diagGen A = diagGen A * projAnti N := by
  unfold projAnti
  simp only [Finset.sum_mul, Finset.mul_sum,
    smul_mul_assoc, mul_smul_comm, permMat_diagGen_comm]

/-- **Lemma 52 (general `N`, antisymmetric case).** The exterior power is a
diagonal `Spin⁺` subrepresentation: `projAnti N` commutes with every diagonal
Lorentz generator `Σᵢ (1⊗…⊗γ^μγ^ν⊗…⊗1)`. -/
theorem projAnti_spinGenDiag_comm {N : ℕ} (μ ν : Fin 4) :
    projAnti N * diagGen (spinGen μ ν) = diagGen (spinGen μ ν) * projAnti N :=
  projAnti_diagGen_comm _

/-- **Lemma 52 (general `N`, antisymmetric case).** The exterior power is also
parity-invariant: `projAnti N` commutes with diagonal parity `γ⁰⊗…⊗γ⁰`.  Thus the
real antisymmetric power is automatically a representation of the full Lorentz
group. -/
theorem projAnti_parityDiag_comm {N : ℕ} :
    projAnti N * uniform (mgamma 0) = uniform (mgamma 0) * projAnti N :=
  projAnti_uniform_comm _

end BookProof.ChapterA3o
