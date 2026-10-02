-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.comm_mom_pos_of_ne
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_ann_comm
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_cre_comm
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_comm_ann_cre_of_ne
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution {i k : Fin 3} (h : i ≠ k) :
    (mom i).comp (pos k) = (pos k).comp (mom i) := by

  have h1 : (ann i).comp (cre k) = (cre k).comp (ann i) := comm_ann_cre_of_ne h
  have h2 : (cre i).comp (ann k) = (ann k).comp (cre i) :=
    (comm_ann_cre_of_ne (Ne.symm h)).symm
  have h3 : (ann i).comp (ann k) = (ann k).comp (ann i) := ann_comm i k
  have h4 : (cre i).comp (cre k) = (cre k).comp (cre i) := cre_comm i k
  simp only [mom, pos, LinearMap.smul_comp, LinearMap.comp_smul,
    LinearMap.comp_add, LinearMap.add_comp, LinearMap.sub_comp, LinearMap.comp_sub,
    h1, h2, h3, h4]
  module
