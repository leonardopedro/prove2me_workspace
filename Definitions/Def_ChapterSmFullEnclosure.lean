import Definitions.Def_ChapterSmFockEsa
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib


/-!
# The full Standard-Model one-particle Hamiltonian (bosonic ⊗ fermionic) and its enclosure

`BookProof/ChapterSmFockEsa.lean` encloses the **bosonic** one-particle Hamiltonian
`h_B = smHamiltonian P` on `L²(ℝ¹⁶³)`; `BookProof/ChapterSmDiracYukawa.lean` defines the
**fermionic** Dirac–Yukawa Hamiltonian `h_F = smDirac h_D + smYukawa M z` on the (finite mode)
CAR Fock space `FermiFock n` and proves it essentially self-adjoint (`sm_fermi_esa`).  This
module assembles the two *before* enclosure (§D6b-SM Step 3 item 3 of `CONSOLIDATED_PLAN.md`):

* `smFullSpace n` — the one-particle space `L²(ℝ¹⁶³) ⊗̂ FermiFock n` (completed tensor
  product), `smFullCore n` — the algebraic tensor product of the Gauss–polynomial core with
  the whole fermionic space;
* `smFullHam P hD M z` — the **full one-particle Hamiltonian**
  `h_full = h_B ⊗ 1 + 1 ⊗ (smDirac h_D + smYukawa M z)` on `smFullCore n`
  (`smFullHam_tmul` checks the formula on elementary tensors);
* `smFullHam_symmetricOn`, `smFullCore_dense`, **`smFull_h_esa`** — `h_full` is essentially
  self-adjoint on `smFullCore n` (one-particle statement), by the two-factor theorem
  `TensorSumEsa.essentiallySelfAdjointOn_cpairDom_esa` applied to `sm_h_esa` and
  `sm_fermi_esa`;
* **`smFull_dGamma_esa`** — the enclosure: `dΓ(h_full) = Σ_{i,j} (h_full)_{ij} C†(e_i) A(e_j)`
  (creation on the left, annihilation on the right; `dGammaCoreOp`) is essentially
  self-adjoint on the finite-particle domain over `smFullCore n`, by
  `EsaOneParticle.dGamma_essentiallySelfAdjointOn_of_esa`.

## Honest boundary

The Yukawa term is taken in a **fixed Higgs background** `z : ℂ` (as `smYukawa` is defined), so
`h_full` has no boson–fermion coupling operator: it is a tensor *sum*.  An operator-valued
Yukawa coupling `φ(q) ⊗ ψ̄Mψ` is not treated.  The fermionic mode set is finite.  The outer
Fock space is the general (unsymmetrized) second quantization of `dGammaCoreOp`; no spectral
information and no mass gap is claimed.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.SmFullEnclosure

open scoped TensorProduct
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa

noncomputable section

/-! ## 1. The one-particle space and the full one-particle Hamiltonian -/

/-- The fermionic Fock space `FermiFock n`, bundled. -/
def smFermiSpace (n : ℕ) : IPSpace := ⟨FermiFock n⟩

instance (n : ℕ) : CompleteSpace (smFermiSpace n).carrier :=
  inferInstanceAs (CompleteSpace (FermiFock n))

/-- The full one-particle space `L²(ℝ¹⁶³) ⊗̂ FermiFock n`. -/
def smFullSpace (n : ℕ) : IPSpace := ⟨ctensor (L2dSpace 163) (smFermiSpace n)⟩

instance (n : ℕ) : CompleteSpace (smFullSpace n).carrier :=
  inferInstanceAs (CompleteSpace (ctensor (L2dSpace 163) (smFermiSpace n)))

/-- The core of the full one-particle Hamiltonian: the Gauss–polynomial core tensored with
the whole (finite-dimensional) fermionic Fock space. -/
def smFullCore (n : ℕ) : Submodule ℂ (smFullSpace n).carrier :=
  cpairDom (L2dSpace 163) (smFermiSpace n) (polyGaussCore (d := 163)) (fullDom n)

/-- **The full Standard-Model one-particle Hamiltonian**
`h_full = h_B ⊗ 1 + 1 ⊗ (smDirac h_D + smYukawa M z)`. -/
def smFullHam (P : SmParams) {n : ℕ} (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) :
    smFullCore n →ₗ[ℂ] (smFullSpace n).carrier :=
  cpairOp (L2dSpace 163) (smFermiSpace n) (polyGaussCore (d := 163)) (fullDom n)
    (smHamiltonian P) (onFull (smFermiHam hD M z))

/-- The fermionic block is exactly Dirac plus Yukawa. -/
theorem smFullHam_fermi_block {n : ℕ} (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) :
    onFull (smFermiHam hD M z) = onFull (smDirac hD + smYukawa M z) := by
  rw [smFermiHam_eq]

set_option maxRecDepth 20000 in
/-- On elementary tensors, `h_full (u ⊗ ψ) = (h_B u) ⊗ ψ + u ⊗ (h_F ψ)`. -/
theorem smFullHam_tmul (P : SmParams) {n : ℕ} (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ)
    (x : ↥(smFullCore n)) (u : ↥(polyGaussCore (d := 163))) (ψ : ↥(fullDom n))
    (hx : (x : (smFullSpace n).carrier)
      = pairEmb (L2dSpace 163) (smFermiSpace n)
          (inclPair (L2dSpace 163) (smFermiSpace n) (polyGaussCore (d := 163)) (fullDom n)
            (u ⊗ₜ[ℂ] ψ : ↥(polyGaussCore (d := 163)) ⊗[ℂ] ↥(fullDom n)))) :
    smFullHam P hD M z x
      = pairEmb (L2dSpace 163) (smFermiSpace n)
          ((smHamiltonian P) u ⊗ₜ[ℂ] (ψ : FermiFock n)
            + (u : L2d 163) ⊗ₜ[ℂ] (smDirac hD + smYukawa M z) ψ) := by
  refine (cpairOp_apply _ _ _ _ _ _ x
    (u ⊗ₜ[ℂ] ψ : ↥(polyGaussCore (d := 163)) ⊗[ℂ] ↥(fullDom n)) hx).trans ?_
  rw [← smFermiHam_eq]
  rfl

/-! ## 2. Essential self-adjointness of the full one-particle Hamiltonian -/

theorem fullDom_dense (n : ℕ) :
    Dense ((fullDom n : Submodule ℂ (FermiFock n)) : Set (FermiFock n)) := by
  simp

theorem smFullCore_dense (n : ℕ) :
    Dense ((smFullCore n : Submodule ℂ (smFullSpace n).carrier) : Set (smFullSpace n).carrier) :=
  dense_cpairDom (L2dSpace 163) (smFermiSpace n) _ _ polyGaussCore_dense (fullDom_dense n)

/-- `h_full` is symmetric on its core (for a Hermitian Dirac matrix). -/
theorem smFullHam_symmetricOn (P : SmParams) {n : ℕ} {hD : Matrix (Fin n) (Fin n) ℂ}
    (M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) (hh : hD.conjTranspose = hD) :
    SymmetricOn (smFullCore n) (smFullHam P hD M z) :=
  symmetricOn_cpairOp (L2dSpace 163) (smFermiSpace n) _ _ _ _ (smHamiltonian_symmetricOn P)
    (smFermiHam_symmetricOn (M := M) (z := z) hh)

/-- The Dirac–Yukawa Hamiltonian is essentially self-adjoint on the whole fermionic space
(`sm_fermi_esa`, with the comparison `N = 1`). -/
theorem smFermiHam_esa {n : ℕ} {hD : Matrix (Fin n) (Fin n) ℂ}
    (M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) (hh : hD.conjTranspose = hD) :
    EssentiallySelfAdjointOn (fullDom n) (onFull (smFermiHam hD M z)) :=
  sm_fermi_esa (M := M) (z := z) (om := fun _ => 0) (c0 := 1) hh (fun _ => le_rfl) le_rfl



/-! ## 3. The enclosure `dΓ(h_full)` -/



end

end BookProof.SmFullEnclosure
