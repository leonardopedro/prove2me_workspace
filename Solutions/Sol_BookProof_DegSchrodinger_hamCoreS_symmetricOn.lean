-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.hamCoreS_symmetricOn
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Theorems.Thm_BookProof_DegSchrodinger_hamCoreS_pgLp
import Theorems.Thm_BookProof_DegSchrodinger_gaussInt_kinPolyS
import Theorems.Thm_BookProof_DegSchrodinger_gaussInt_kinPolyS_left
import Theorems.Thm_BookProof_QgHermiteFriedrichs_inner_pgLp_pgLp
import Theorems.Thm_BookProof_QgHermiteFriedrichs_inner_potLp_symm
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (W : Vd d → ℝ) (hWc : Continuous W) (hWb : ExpBounded W)
    (S : Finset (Fin d)) :
    SymmetricOn (polyGaussCore (d := d)) (hamCoreS W hWc hWb S) := by

  intro x y
  obtain ⟨p, hp⟩ := x.2
  obtain ⟨q, hq⟩ := y.2
  have hx : x = ⟨pgLp p, pgLp_mem_core p⟩ := Subtype.ext hp.symm
  have hy : y = ⟨pgLp q, pgLp_mem_core q⟩ := Subtype.ext hq.symm
  rw [hx, hy, hamCoreS_pgLp, hamCoreS_pgLp]
  change (inner ℂ (hamPolyS W hWc hWb S p) (pgLp q) : ℂ)
    = inner ℂ (pgLp p) (hamPolyS W hWc hWb S q)
  simp only [hamPolyS, inner_add_left, inner_add_right]
  congr 1
  · rw [QgHermiteFriedrichs.inner_pgLp_pgLp, QgHermiteFriedrichs.inner_pgLp_pgLp,
      gaussInt_kinPolyS_left, gaussInt_kinPolyS]
  · exact inner_potLp_symm W hWc hWb p q
