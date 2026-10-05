import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_avgProj_mem

import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_commutes_avgProj

import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_mem_range_avgProj_iff

import Theorems.Thm_BookProof_PermSector_permRep_mem_sectorDom

import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_isReducingProjection_avgProj

import Theorems.Thm_BookProof_PermSector_signRep_mem_sectorDom

import Theorems.Thm_BookProof_PermSector_permRep_commutes_sectorDom



import Theorems.Thm_BookProof_PermSector_signRep_commutes_sectorDom




import Definitions.Def_ChapterFockStatisticsEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterEsaOneParticleDGamma
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorPermutation
import Mathlib


/-!
# The Hilbert bosonic and fermionic Fock space

`BookProof.FockStatistics` works inside the *algebraic* tensor powers `H^{⊗n}`.  This module
repeats the construction inside their **completions** — the `n`-particle sectors
`fockSector Hs n` of `BookProof.SecondQuantizationCore` — so that the symmetric and the
antisymmetric Fock space obtained by summing over the particle number are genuine Hilbert
spaces.

## What is proved

* `UnitaryRep.completionRep` — a unitary representation of a finite group on an inner
  product space extends to its completion, with `completionRep_act_coe` the compatibility
  with the canonical embedding; `isClosed_sector_avgProj` — the invariant sector of the
  extended representation is closed, hence complete.
* `cpermRep`, `csignRep`, `cbosonicProj`, `cfermionicProj` — the permutation action, its sign
  twist and the two averages on the completed sector `fockSector Hs n`;
  `mem_cbosonicSector_iff`, `mem_cfermionicSector_iff`, and `cbosonicProj_sectorEmb` /
  `cfermionicProj_sectorEmb`: the completed projections extend the algebraic ones.
* `essentiallySelfAdjointOn_cbosonic`, `essentiallySelfAdjointOn_cfermionic` — `dΓ(A)⁽ⁿ⁾` is
  essentially self-adjoint on the symmetric and on the antisymmetric part of the *complete*
  `n`-particle sector, for a symmetric essentially self-adjoint one-particle operator.
* `hbosonicFock`, `hfermionicFock` — the two Hilbert Fock spaces (`CompleteSpace` instances
  included), `hbosonicFockDom` / `hbosonicFockOp` and their fermionic twins, and the headline
  **`hbosonicFock_esa`** / **`hfermionicFock_esa`**: `dΓ(A)` is essentially self-adjoint on
  the symmetric, respectively the antisymmetric, Fock space over `H`, with
  `hbosonicFock_symmetricOn` / `hfermionicFock_symmetricOn` the symmetry statements.
* `exists_ne_zero_cbosonic`, `exists_ne_zero_cfermionic`, `exists_ne_zero_hbosonicFockDom`,
  `exists_ne_zero_hfermionicFockDom` — non-vacuity: the `n`-th power of a nonzero vector of
  the one-particle domain and the Slater determinant of `n` pairwise orthogonal ones survive
  in the completed sectors and in the two Fock domains.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.GroupAverage.UnitaryRep

open BookProof.GroupAverage BookProof.ReducedEsa

noncomputable section

/-! ## 1. A unitary representation extends to the completion -/

section CompletionRep

variable {G : Type*} [Group G] [Fintype G] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]



omit [Fintype G] in
/-- Every operator of a unitary representation is an isometry. -/
theorem norm_act (rep : UnitaryRep G F) (g : G) (x : F) : ‖rep.act g x‖ = ‖x‖ := by
  have h := rep.act_inner g x x
  rw [inner_self_eq_norm_sq_to_K, inner_self_eq_norm_sq_to_K] at h
  have h2 : ‖rep.act g x‖ ^ 2 = ‖x‖ ^ 2 := by exact_mod_cast h
  nlinarith [norm_nonneg (rep.act g x), norm_nonneg x]

/-- The operator of a unitary representation, as a continuous linear map. -/
def actL (rep : UnitaryRep G F) (g : G) : F →L[ℂ] F :=
  LinearMap.mkContinuous (rep.act g) 1 (fun x => by rw [rep.norm_act, one_mul])

omit [Fintype G] in
@[simp] theorem actL_apply (rep : UnitaryRep G F) (g : G) (x : F) :
    rep.actL g x = rep.act g x := rfl

/-- **A unitary representation of a finite group extends to the completion.** -/
def completionRep (rep : UnitaryRep G F) : UnitaryRep G (UniformSpace.Completion F) where
  act g := ((rep.actL g).completion : UniformSpace.Completion F →L[ℂ]
    UniformSpace.Completion F).toLinearMap
  act_one x := by
    refine UniformSpace.Completion.induction_on x
      (isClosed_eq (ContinuousLinearMap.continuous _) continuous_id) (fun a => ?_)
    change (rep.actL 1).completion (a : UniformSpace.Completion F) = (a : _)
    rw [ContinuousLinearMap.completion_apply_coe]
    simp [rep.act_one a]
  act_mul g h x := by
    refine UniformSpace.Completion.induction_on x
      (isClosed_eq (ContinuousLinearMap.continuous _)
        ((ContinuousLinearMap.continuous _).comp (ContinuousLinearMap.continuous _)))
      (fun a => ?_)
    change (rep.actL (g * h)).completion (a : UniformSpace.Completion F)
      = (rep.actL g).completion ((rep.actL h).completion (a : UniformSpace.Completion F))
    rw [ContinuousLinearMap.completion_apply_coe, ContinuousLinearMap.completion_apply_coe,
      ContinuousLinearMap.completion_apply_coe]
    simp [rep.act_mul g h a]
  act_inner g x y := by
    refine UniformSpace.Completion.induction_on₂ x y
      (isClosed_eq (Continuous.inner
        (((ContinuousLinearMap.continuous _).comp continuous_fst))
        (((ContinuousLinearMap.continuous _).comp continuous_snd)))
        (continuous_inner)) (fun a b => ?_)
    change (inner ℂ ((rep.actL g).completion (a : UniformSpace.Completion F))
      ((rep.actL g).completion (b : UniformSpace.Completion F)) : ℂ)
      = inner ℂ (a : UniformSpace.Completion F) (b : UniformSpace.Completion F)
    rw [ContinuousLinearMap.completion_apply_coe, ContinuousLinearMap.completion_apply_coe]
    rw [UniformSpace.Completion.inner_coe, UniformSpace.Completion.inner_coe]
    exact rep.act_inner g a b

omit [Fintype G] in
@[simp] theorem completionRep_act_coe (rep : UnitaryRep G F) (g : G) (x : F) :
    rep.completionRep.act g (x : UniformSpace.Completion F)
      = ((rep.act g x : F) : UniformSpace.Completion F) := by
  change (rep.actL g).completion (x : UniformSpace.Completion F) = _
  rw [ContinuousLinearMap.completion_apply_coe]
  rfl

/-- The invariant sector of the extended representation is a **closed** subspace: it is the
intersection of the fixed-point sets of the (continuous) operators of the action. -/
theorem isClosed_sector_completionRep (rep : UnitaryRep G F) :
    IsClosed (sector rep.completionRep.avgProj : Set (UniformSpace.Completion F)) := by
  have hset : (sector rep.completionRep.avgProj : Set (UniformSpace.Completion F))
      = ⋂ g : G, {x | rep.completionRep.act g x = x} := by
    ext x
    simp only [Set.mem_iInter, Set.mem_setOf_eq]
    exact rep.completionRep.mem_range_avgProj_iff
  rw [hset]
  refine isClosed_iInter (fun g => isClosed_eq ?_ continuous_id)
  exact (ContinuousLinearMap.continuous ((rep.actL g).completion))

instance completeSpace_sector_completionRep (rep : UnitaryRep G F) :
    CompleteSpace (sector rep.completionRep.avgProj) :=
  (rep.isClosed_sector_completionRep).completeSpace_coe



end CompletionRep
end

end BookProof.GroupAverage.UnitaryRep

namespace BookProof.FockStatistics

open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm BookProof.PermSector
open BookProof.SecondQuantizationCore BookProof.EsaOneParticle BookProof.DirectSumEsa

noncomputable section


/-! ## 2. The permutation action on the complete `n`-particle sector -/

section Complete

variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)



/-- The permutation action on the completed `n`-particle sector. -/
def cpermRep (n : ℕ) : UnitaryRep (Equiv.Perm (Fin n)) (fockSector Hs n) :=
  (permRep Hs n).completionRep

/-- Its sign twist. -/
def csignRep (n : ℕ) : UnitaryRep (Equiv.Perm (Fin n)) (fockSector Hs n) :=
  (signRep Hs n).completionRep

/-- The **symmetrizer** of the completed `n`-particle sector. -/
def cbosonicProj (n : ℕ) : fockSector Hs n →ₗ[ℂ] fockSector Hs n := (cpermRep Hs n).avgProj

/-- The **antisymmetrizer** of the completed `n`-particle sector. -/
def cfermionicProj (n : ℕ) : fockSector Hs n →ₗ[ℂ] fockSector Hs n := (csignRep Hs n).avgProj

theorem isReducingProjection_cbosonicProj (n : ℕ) :
    IsReducingProjection (cbosonicProj Hs n) :=
  (cpermRep Hs n).isReducingProjection_avgProj

theorem isReducingProjection_cfermionicProj (n : ℕ) :
    IsReducingProjection (cfermionicProj Hs n) :=
  (csignRep Hs n).isReducingProjection_avgProj

/-- **The symmetric part of the complete sector is a closed subspace**, hence a Hilbert
space. -/
instance completeSpace_cbosonicSector (n : ℕ) :
    CompleteSpace (sector (cbosonicProj Hs n)) :=
  (permRep Hs n).completeSpace_sector_completionRep

/-- **The antisymmetric part of the complete sector is a closed subspace.** -/
instance completeSpace_cfermionicSector (n : ℕ) :
    CompleteSpace (sector (cfermionicProj Hs n)) :=
  (signRep Hs n).completeSpace_sector_completionRep









/-! ### The action preserves the domain and commutes with the derivation -/

theorem cpermRep_mem_fockSectorDom (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : fockSector Hs n)
    (hx : x ∈ fockSectorDom Hs D n) : (cpermRep Hs n).act σ x ∈ fockSectorDom Hs D n := by
  obtain ⟨v, hv, rfl⟩ := hx
  refine ⟨(permRep Hs n).act σ v, permRep_mem_sectorDom Hs D n σ v hv, ?_⟩
  exact ((permRep Hs n).completionRep_act_coe σ v).symm

theorem csignRep_mem_fockSectorDom (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : fockSector Hs n)
    (hx : x ∈ fockSectorDom Hs D n) : (csignRep Hs n).act σ x ∈ fockSectorDom Hs D n := by
  obtain ⟨v, hv, rfl⟩ := hx
  refine ⟨(signRep Hs n).act σ v, signRep_mem_sectorDom Hs D n σ v hv, ?_⟩
  exact ((signRep Hs n).completionRep_act_coe σ v).symm

theorem cpermRep_commutes_fockSectorDom (n : ℕ) (σ : Equiv.Perm (Fin n))
    (x : fockSectorDom Hs D n) :
    fockSectorOp Hs D A n ⟨(cpermRep Hs n).act σ (x : fockSector Hs n),
        cpermRep_mem_fockSectorDom Hs D n σ _ x.2⟩
      = (cpermRep Hs n).act σ (fockSectorOp Hs D A n x) := by
  obtain ⟨v, hv, hvx⟩ := x.2
  set v' : sectorDom Hs D n := ⟨v, hv⟩ with hv'
  have hx : (x : fockSector Hs n) = sectorEmb Hs n (v' : (Hs.pow n).carrier) := hvx.symm
  have hact : ((cpermRep Hs n).act σ (x : fockSector Hs n))
      = sectorEmb Hs n ((permRep Hs n).act σ v) := by
    rw [hx]
    exact (permRep Hs n).completionRep_act_coe σ v
  have h1 : fockSectorOp Hs D A n ⟨(cpermRep Hs n).act σ (x : fockSector Hs n),
        cpermRep_mem_fockSectorDom Hs D n σ _ x.2⟩
      = sectorEmb Hs n (sectorOp Hs D A n
          ⟨(permRep Hs n).act σ v, permRep_mem_sectorDom Hs D n σ v hv⟩) :=
    pushOp_apply (sectorEmb Hs n) (sectorOp Hs D A n) _ _ hact
  have h2 : fockSectorOp Hs D A n x = sectorEmb Hs n (sectorOp Hs D A n v') :=
    pushOp_apply (sectorEmb Hs n) (sectorOp Hs D A n) x v' hx
  have h3 : (cpermRep Hs n).act σ (sectorEmb Hs n (sectorOp Hs D A n v'))
      = sectorEmb Hs n ((permRep Hs n).act σ (sectorOp Hs D A n v')) :=
    (permRep Hs n).completionRep_act_coe σ _
  rw [h1, h2, h3]
  exact congrArg (sectorEmb Hs n) (permRep_commutes_sectorDom Hs D A n σ v')

theorem csignRep_commutes_fockSectorDom (n : ℕ) (σ : Equiv.Perm (Fin n))
    (x : fockSectorDom Hs D n) :
    fockSectorOp Hs D A n ⟨(csignRep Hs n).act σ (x : fockSector Hs n),
        csignRep_mem_fockSectorDom Hs D n σ _ x.2⟩
      = (csignRep Hs n).act σ (fockSectorOp Hs D A n x) := by
  obtain ⟨v, hv, hvx⟩ := x.2
  set v' : sectorDom Hs D n := ⟨v, hv⟩ with hv'
  have hx : (x : fockSector Hs n) = sectorEmb Hs n (v' : (Hs.pow n).carrier) := hvx.symm
  have hact : ((csignRep Hs n).act σ (x : fockSector Hs n))
      = sectorEmb Hs n ((signRep Hs n).act σ v) := by
    rw [hx]
    exact (signRep Hs n).completionRep_act_coe σ v
  have h1 : fockSectorOp Hs D A n ⟨(csignRep Hs n).act σ (x : fockSector Hs n),
        csignRep_mem_fockSectorDom Hs D n σ _ x.2⟩
      = sectorEmb Hs n (sectorOp Hs D A n
          ⟨(signRep Hs n).act σ v, signRep_mem_sectorDom Hs D n σ v hv⟩) :=
    pushOp_apply (sectorEmb Hs n) (sectorOp Hs D A n) _ _ hact
  have h2 : fockSectorOp Hs D A n x = sectorEmb Hs n (sectorOp Hs D A n v') :=
    pushOp_apply (sectorEmb Hs n) (sectorOp Hs D A n) x v' hx
  have h3 : (csignRep Hs n).act σ (sectorEmb Hs n (sectorOp Hs D A n v'))
      = sectorEmb Hs n ((signRep Hs n).act σ (sectorOp Hs D A n v')) :=
    (signRep Hs n).completionRep_act_coe σ _
  rw [h1, h2, h3]
  exact congrArg (sectorEmb Hs n) (signRep_commutes_sectorDom Hs D A n σ v')

/-- `dΓ(A)⁽ⁿ⁾` reduced to the symmetric part of the complete `n`-particle sector. -/
def cbosonicSectorOp (n : ℕ) :
    redDom (cbosonicProj Hs n) (fockSectorDom Hs D n) →ₗ[ℂ] sector (cbosonicProj Hs n) :=
  redOp (fockSectorOp Hs D A n) (isReducingProjection_cbosonicProj Hs n)
    ((cpermRep Hs n).commutes_avgProj
      (hD := cpermRep_mem_fockSectorDom Hs D n)
      (cpermRep_commutes_fockSectorDom Hs D A n))

/-- `dΓ(A)⁽ⁿ⁾` reduced to the antisymmetric part of the complete `n`-particle sector. -/
def cfermionicSectorOp (n : ℕ) :
    redDom (cfermionicProj Hs n) (fockSectorDom Hs D n) →ₗ[ℂ] sector (cfermionicProj Hs n) :=
  redOp (fockSectorOp Hs D A n) (isReducingProjection_cfermionicProj Hs n)
    ((csignRep Hs n).commutes_avgProj
      (hD := csignRep_mem_fockSectorDom Hs D n)
      (csignRep_commutes_fockSectorDom Hs D A n))

end Complete


/-! ## 3. Essential self-adjointness on the complete sectors -/

section CompleteEsa

variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
  (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
  (hesa : EssentiallySelfAdjointOn D A)









end CompleteEsa

/-! ## 4. The two Hilbert Fock spaces -/

section HilbertFock

variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)

/-- **The bosonic Fock space** over `H`, as a Hilbert space: the `ℓ²` direct sum over the
particle number of the symmetric part of the complete `n`-particle sector. -/
abbrev hbosonicFock : Type := lp (fun n : ℕ => ↥(sector (cbosonicProj Hs n))) 2

/-- **The fermionic Fock space** over `H`, as a Hilbert space. -/
abbrev hfermionicFock : Type := lp (fun n : ℕ => ↥(sector (cfermionicProj Hs n))) 2

instance completeSpace_hbosonicFock : CompleteSpace (hbosonicFock Hs) := by
  infer_instance

instance completeSpace_hfermionicFock : CompleteSpace (hfermionicFock Hs) := by
  infer_instance

/-- The domain of `dΓ(A)` on the bosonic Fock space. -/
def hbosonicFockDom : Submodule ℂ (hbosonicFock Hs) :=
  dsCore (fun n : ℕ => redDom (cbosonicProj Hs n) (fockSectorDom Hs D n))

/-- The domain of `dΓ(A)` on the fermionic Fock space. -/
def hfermionicFockDom : Submodule ℂ (hfermionicFock Hs) :=
  dsCore (fun n : ℕ => redDom (cfermionicProj Hs n) (fockSectorDom Hs D n))

/-- **`dΓ(A)` on the bosonic Fock space.** -/
def hbosonicFockOp : hbosonicFockDom Hs D →ₗ[ℂ] hbosonicFock Hs :=
  dsOp (fun n : ℕ => cbosonicSectorOp Hs D A n)

/-- **`dΓ(A)` on the fermionic Fock space.** -/
def hfermionicFockOp : hfermionicFockDom Hs D →ₗ[ℂ] hfermionicFock Hs :=
  dsOp (fun n : ℕ => cfermionicSectorOp Hs D A n)

end HilbertFock

section HilbertFockEsa

variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
  (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
  (hesa : EssentiallySelfAdjointOn D A)









end HilbertFockEsa

/-! ## 5. Non-vacuity -/

section NonVacuous

variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier)













end NonVacuous

end

end BookProof.FockStatistics
