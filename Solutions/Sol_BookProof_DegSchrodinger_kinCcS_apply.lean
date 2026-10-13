-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.kinCcS_apply
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Theorems.Thm_BookProof_StrichartzWave_opL2_apply
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterStrichartzWave
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.ScalaronEsa
open BookProof.StrichartzWave

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (S : Finset (Fin d)) (f : ccSchwartz (Vd d)) :
    kinCcS S (ccEquiv (Vd d) f)
      = (kinOpS S (f : 𝓢(Vd d, ℂ))).toLp 2 (volume : Measure (Vd d)) := by

  have hincl : Submodule.inclusion (ccDomain_le_schwartzDomain (E := Vd d)) (ccEquiv (Vd d) f)
      = schwartzEquiv (Vd d) ((f : 𝓢(Vd d, ℂ))) := Subtype.ext rfl
  simp only [kinCcS, LinearMap.coe_comp, Function.comp_apply, hincl, opL2_apply]
