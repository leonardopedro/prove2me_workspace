import Mathlib
import BookProof.ChapterDirectSumEsa
import BookProof.ChapterKatoRellichDeficiency
import BookProof.ChapterStoneBridge
import BookProof.ChapterYangMillsAbelianEsa

/-!
# The Faddeev–Popov ghost sector of the 3D gauge-fixed Yang–Mills Hamiltonian

The gauge-fixing machinery of the development is algebraic
(`BookProof.ChapterGaugeFixing`: the BRST doublets and the gauge-fixing fermion,
`BookProof.ChapterGhostField`: the ghost CAR pair and the ghost number operator) and the
BRST-gauge-fixed *Hamiltonians* that exist are the gravity ones
(`BookProof.ChapterQgBrstDerivativeGauge`).  On the Yang–Mills side the Hamiltonian carried
no ghost sector at all.  This chapter supplies it.

## The model

`K` ghost mode pairs `(c_p, c̄_p)` give a finite-dimensional ghost Fock space with basis the
ghost configurations `S ⊆ {0,…,K−1}`, so the total space is the orthogonal direct sum

`𝔉 = ⨁_{S ⊆ Fin K} L²(ℝ⁹⁹)`  (`GhostSpace K`),

the gauge sector tensored with the ghost Fock space.  For a **free** ghost sector — the
Faddeev–Popov operator of the abelian gauge fixing is field independent, which is the formal
content of `L_gf_evaluation`'s "the ghosts drop out of the physics" — the ghost Hamiltonian
is diagonal in that basis, with eigenvalue the ghost energy `E(S) = Σ_{p ∈ S} ω_p`, so the
total Hamiltonian is

`H_tot = H₁ ⊗ 1 + 1 ⊗ H_gh = ⨁_S (H₁ + E(S))`  (`ymGhostHam`).

## What is proved

* `ghostNum`, `ghostEnergy`, `ghostEnergy_empty`, `ghostEnergy_nonneg` — the ghost number and
  the ghost energy.
* `ghostCore`, `ghostCore_dense`, `fibreHam`, `ymGhostHam` — the glued core and the total
  Hamiltonian, for **every** family of structure constants and every ghost dispersion.
* `fibreHam_symmetricOn`, **`ymGhostHam_symmetricOn`** — symmetry, unconditional.
* **`ymGhostHam_preserves_ghostNumber`** — ghost number is conserved: the Hamiltonian
  preserves every ghost-number sector.  `ymGhostHam_fibre` and
  **`ymGhostHam_vacuum_fibre`** — on the ghost vacuum `S = ∅` the total Hamiltonian *is* the
  gauge-sector Hamiltonian `H₁`: the ghosts decouple.
* **`ymGhostHam_essentiallySelfAdjointOn_core`** — for the abelian (QED) gauge fixing
  `f_abc = 0` the total gauge+ghost Hamiltonian is essentially self-adjoint on the glued
  Gauss–polynomial core, hence has a unique self-adjoint realization
  (`ymGhostHam_stone_flow` is the unitary group it generates).
* **`ymGhostHam_add_bounded_coupling_esa`** — the same after adding an arbitrary *bounded*
  symmetric gauge–ghost coupling, by Kato–Rellich: any regulated Faddeev–Popov coupling is
  covered.

## Honest boundary

For `f_abc ≠ 0` the Faddeev–Popov operator depends on the gauge field, so the ghost coupling
is an unbounded multiplication operator; neither the free statement nor the bounded-coupling
statement applies to it, and the gauge sector itself is then the open quartic problem of
`BookProof.ChapterYangMillsBandBounds`.  Symmetry, ghost-number conservation and the
decoupling of the ghost vacuum hold for every `f_abc`; only the self-adjointness statements
are restricted to the abelian case.  No mass gap and no spectral claim is made.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.YangMillsGhost

noncomputable section

open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite BookProof.YangMillsAbelianEsa
open BookProof.KatoRellich BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent

variable {K : ℕ}

/-! ## The ghost configurations -/

/-- A ghost configuration: the set of occupied ghost modes. -/
abbrev GConf (K : ℕ) := Finset (Fin K)

/-- The ghost number of a configuration. -/
def ghostNum (S : GConf K) : ℕ := S.card

/-- The ghost energy of a configuration, for the ghost dispersion `ω`. -/
def ghostEnergy (ω : Fin K → ℝ) (S : GConf K) : ℝ := ∑ p ∈ S, ω p

@[simp] theorem ghostEnergy_empty (ω : Fin K → ℝ) : ghostEnergy ω (∅ : GConf K) = 0 := by
  simp [ghostEnergy]

theorem ghostEnergy_nonneg {ω : Fin K → ℝ} (hω : ∀ p, 0 ≤ ω p) (S : GConf K) :
    0 ≤ ghostEnergy ω S :=
  Finset.sum_nonneg fun p _ => hω p

/-! ## The total space and the glued core -/

/-- The gauge sector tensored with the ghost Fock space: one copy of `L²(ℝ⁹⁹)` for every
ghost configuration. -/
abbrev GhostSpace (K : ℕ) := lp (fun _ : GConf K => L2d 99) 2

/-- The glued Gauss–polynomial core. -/
def ghostCore (K : ℕ) : Submodule ℂ (GhostSpace K) :=
  dsCore (fun _ : GConf K => polyGaussCore (d := 99))

theorem ghostCore_dense : Dense ((ghostCore K : Submodule ℂ (GhostSpace K)) : Set (GhostSpace K)) :=
  dsCore_dense fun _ => polyGaussCore_dense

/-! ## The Hamiltonian -/

/-- The fibre Hamiltonian on the ghost configuration `S`: the gauge-fixed Yang–Mills
Hamiltonian shifted by the ghost energy of `S`. -/
def fibreHam (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (ω : Fin K → ℝ) (S : GConf K) :
    polyGaussCore (d := 99) →ₗ[ℂ] L2d 99 :=
  ymHamiltonian (coreRepPoly 99) fabc
    + ((((ghostEnergy ω S : ℝ) : ℂ) • ContinuousLinearMap.id ℂ (L2d 99)).toLinearMap
        ∘ₗ (polyGaussCore (d := 99)).subtype)

theorem fibreHam_apply (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (ω : Fin K → ℝ) (S : GConf K)
    (x : polyGaussCore (d := 99)) :
    fibreHam fabc ω S x
      = ymHamiltonian (coreRepPoly 99) fabc x + ((ghostEnergy ω S : ℝ) : ℂ) • (x : L2d 99) :=
  rfl

/-- **The total gauge + ghost Hamiltonian** `H_tot = ⨁_S (H₁ + E(S))`. -/
def ymGhostHam (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (ω : Fin K → ℝ) :
    ghostCore K →ₗ[ℂ] GhostSpace K :=
  dsOp (fibreHam fabc ω)

theorem ymGhostHam_fibre (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (ω : Fin K → ℝ)
    (x : ghostCore K) (S : GConf K) :
    ((ymGhostHam fabc ω x : GhostSpace K) : ∀ _ : GConf K, L2d 99) S
      = fibreHam fabc ω S ⟨(x : GhostSpace K) S, x.2.2 S⟩ := rfl

set_option maxHeartbeats 1000000 in
-- the direct-sum coercions of `lp` over the ghost configurations make the defeq checks here
-- expensive
/-- **On the ghost vacuum the ghosts decouple**: the total Hamiltonian restricted to the
empty ghost configuration is the gauge-sector Hamiltonian `H₁` itself. -/
theorem ymGhostHam_vacuum_fibre (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (ω : Fin K → ℝ)
    (x : ghostCore K) :
    ((ymGhostHam fabc ω x : GhostSpace K) : ∀ _ : GConf K, L2d 99) ∅
      = ymHamiltonian (coreRepPoly 99) fabc ⟨(x : GhostSpace K) ∅, x.2.2 ∅⟩ := by
  rw [ymGhostHam_fibre, fibreHam_apply, ghostEnergy_empty]
  simp

/-! ## Symmetry -/

set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make the defeq checks here expensive
theorem fibreHam_symmetricOn (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (ω : Fin K → ℝ)
    (S : GConf K) : SymmetricOn (polyGaussCore (d := 99)) (fibreHam fabc ω S) := by
  intro x y
  have hsym := ymHamiltonian_symmetricOn (coreRepPoly 99) fabc x y
  rw [fibreHam_apply, fibreHam_apply, inner_add_left, inner_add_right, hsym,
    inner_smul_left, inner_smul_right]
  simp

/-- **The total gauge + ghost Hamiltonian is symmetric**, for every family of structure
constants and every ghost dispersion. -/
theorem ymGhostHam_symmetricOn (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (ω : Fin K → ℝ) :
    SymmetricOn (ghostCore K) (ymGhostHam fabc ω) :=
  dsOp_symmetricOn _ (fibreHam_symmetricOn fabc ω)

/-! ## Ghost number is conserved -/

/-- **Ghost number conservation**: if a core state is supported on ghost configurations of
ghost number `n`, so is its image under the Hamiltonian. -/
theorem ymGhostHam_preserves_ghostNumber (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (ω : Fin K → ℝ)
    (n : ℕ) (x : ghostCore K)
    (hx : ∀ S : GConf K, ghostNum S ≠ n → (x : GhostSpace K) S = 0) :
    ∀ S : GConf K, ghostNum S ≠ n →
      ((ymGhostHam fabc ω x : GhostSpace K) : ∀ _ : GConf K, L2d 99) S = 0 := by
  intro S hS
  have hzero : (⟨(x : GhostSpace K) S, x.2.2 S⟩ : polyGaussCore (d := 99)) = 0 :=
    Subtype.ext (hx S hS)
  rw [ymGhostHam_fibre, hzero, map_zero]

/-! ## Essential self-adjointness in the abelian (QED) case -/

/-- Each fibre of the abelian gauge + ghost Hamiltonian is essentially self-adjoint: `H₁` is
(`ymAbelian_essentiallySelfAdjointOn_core`) and the ghost energy is a bounded symmetric
perturbation. -/
theorem fibreHam_abelian_esa (ω : Fin K → ℝ) (S : GConf K) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 99)) (fibreHam 0 ω S) :=
  essentiallySelfAdjointOn_add_bounded _ (ymHamiltonian_symmetricOn (coreRepPoly 99) 0)
    ymAbelian_essentiallySelfAdjointOn_core
    (((ghostEnergy ω S : ℝ) : ℂ) • ContinuousLinearMap.id ℂ (L2d 99))
    (fun u v => by
      simp only [ContinuousLinearMap.smul_apply, ContinuousLinearMap.id_apply,
        inner_smul_left, inner_smul_right, Complex.conj_ofReal])

/-- **The abelian (QED) gauge-fixed Yang–Mills Hamiltonian with its Faddeev–Popov ghost
sector is essentially self-adjoint** on the glued Gauss–polynomial core. -/
theorem ymGhostHam_essentiallySelfAdjointOn_core (ω : Fin K → ℝ) :
    EssentiallySelfAdjointOn (ghostCore K) (ymGhostHam 0 ω) :=
  dsOp_essentiallySelfAdjointOn _ (fibreHam_abelian_esa ω)

/-- **The unitary flow of the abelian gauge + ghost Hamiltonian.** -/
theorem ymGhostHam_stone_flow (ω : Fin K → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (GhostSpace K)) (U : ℝ → (GhostSpace K →L[ℂ] GhostSpace K)),
      IsSelfAdjointExtension (ymGhostHam 0 ω) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ ghostCore_dense (ymGhostHam_symmetricOn 0 ω)
    (ymGhostHam_essentiallySelfAdjointOn_core ω)

/-- **Any bounded symmetric gauge–ghost coupling is admissible**: adding a bounded symmetric
operator — a regulated Faddeev–Popov coupling between the gauge and ghost sectors, which need
not be diagonal in the ghost configurations — preserves essential self-adjointness. -/
theorem ymGhostHam_add_bounded_coupling_esa (ω : Fin K → ℝ)
    (B : GhostSpace K →L[ℂ] GhostSpace K)
    (hB : ∀ x y : GhostSpace K, (inner ℂ (B x) y : ℂ) = inner ℂ x (B y)) :
    EssentiallySelfAdjointOn (ghostCore K)
      (ymGhostHam 0 ω + (B.toLinearMap ∘ₗ (ghostCore K).subtype)) :=
  essentiallySelfAdjointOn_add_bounded _ (ymGhostHam_symmetricOn 0 ω)
    (ymGhostHam_essentiallySelfAdjointOn_core ω) B hB

end

end BookProof.YangMillsGhost
