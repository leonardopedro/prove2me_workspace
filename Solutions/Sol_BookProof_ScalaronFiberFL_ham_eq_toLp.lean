-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.ham_eq_toLp
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_ScalaronEsa_opCc_apply
import Theorems.Thm_BookProof_StrichartzWave_opL2_apply
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (s : ℝ) (f : ccSchwartz ℝ) :
    W.ham s (ccEquiv ℝ f) = (hamS W s f).toLp 2 (volume : Measure ℝ) := by

  have hincl : Submodule.inclusion (ccDomain_le_schwartzDomain (E := ℝ)) (ccEquiv ℝ f)
      = schwartzEquiv ℝ (f : 𝓢(ℝ, ℂ)) := Subtype.ext rfl
  have hkin : kinCcR (ccEquiv ℝ f) = (kinOpR (f : 𝓢(ℝ, ℂ))).toLp 2 (volume : Measure ℝ) := by
    simp only [kinCcR, LinearMap.coe_comp, Function.comp_apply, hincl, opL2_apply]
  have hpot : opCc (W.pot s) (W.pot_smooth s) (ccEquiv ℝ f)
      = (mulCc (W.pot s) (W.pot_smooth s) f).toLp 2 (volume : Measure ℝ) := opCc_apply _ _ _
  change (kinCcR + opCc (W.pot s) (W.pot_smooth s)) (ccEquiv ℝ f) = _
  rw [LinearMap.add_apply, hkin, hpot, hamS]
  exact (map_add (toLpCLM ℂ ℂ 2 (volume : Measure ℝ)) _ _).symm
